import UIKit

protocol ConverterCurrencyPresenterProtocol {
    var title: String { get }

    func viewDidLoad()
    func soldCurrencyTapped()
    func editButtonTapped()
    func updateAmount(text: String)
}

final class ConverterCurrencyPresenter: ConverterCurrencyPresenterProtocol {
    weak var view: ConverterCurrencyViewProtocol?

    var title: String { "Currencies" }

    private var isRequestNeeded = true
    private var symbolsModel: SymbolsModel?
    private var ratesModel: RatesModel?

    private var soldCurrencyModel: ConverterCurrencyView.SoldCurrencyModel = .init(
        currencyKey: "",
        currencyName: ""
    )

    private let symbolsService: SymbolsServiceProtocol
    private let ratesService: RatesServiceProtocol
    private let tableManager = ConverterCurrencyViewTableManager()
    private let router: ConverterCurrencyRouterProtocol

    private let rateDecimals: String
    private let amountDecimals: String

    private var soldCurrency: CurrencyId {
        didSet {
            if oldValue != soldCurrency {
                soldCurrencyModel = createSoldCurrencyModel(currencyID: soldCurrency)
                view?.updateSoldCurrency(model: soldCurrencyModel)
                isRequestNeeded = true
                updateTablePurchasedCurrencies()
            }
        }
    }

    private var purchasedCurrencyList: [CurrencyId] {
        didSet {
            if oldValue != purchasedCurrencyList {
                isRequestNeeded = true
                updateTablePurchasedCurrencies()
            }
        }
    }

    init(
        soldCurrency: CurrencyId,
        purchasedCurrencyList: [CurrencyId],
        rateDecimals: String,
        amountDecimals: String,
        symbolsService: SymbolsServiceProtocol,
        ratesService: RatesServiceProtocol,
        router: ConverterCurrencyRouterProtocol
    ) {
        self.soldCurrency = soldCurrency
        self.purchasedCurrencyList = purchasedCurrencyList
        self.rateDecimals = rateDecimals
        self.amountDecimals = amountDecimals
        self.symbolsService = symbolsService
        self.ratesService = ratesService
        self.router = router
    }

    func viewDidLoad() {
        view?.startLoader()

        let group = DispatchGroup()

        group.enter()
        symbolsService.fetchSymbols(queue: .main) { [self] result in
            switch result {
            case let .success(data):
                symbolsModel = data
            case let .failure(error):
                print(error)
            }
            group.leave()
        }

        group.enter()
        ratesService.fetchRates(base: soldCurrency, symbols: purchasedCurrencyList, queue: .main) { [self] result in
            switch result {
            case let .success(data):
                ratesModel = data
                isRequestNeeded = false
                print("Data obtained from the network ")
            case let .failure(error):
                print(error)
            }
            group.leave()
        }

        group.notify(queue: DispatchQueue.main) { [self] in
            soldCurrencyModel = createSoldCurrencyModel(currencyID: soldCurrency)
            view?.updateSoldCurrency(model: soldCurrencyModel)
            updateTablePurchasedCurrencies()
            view?.stopLoader()
        }
    }

    func updateAmount(text: String) {
        guard let amount = Double(text) else {
            print("incorrect number")
            return
        }

        soldCurrencyModel.amount = String(amount)
        if isRequestNeeded {
            updateRatesCurrencies()
        } else {
            updateTablePurchasedCurrencies()
        }
    }

    func soldCurrencyTapped() {
        guard let model = symbolsModel else { return }
        router.openSelectionCurrency(
            currencyKey: soldCurrency,
            symbolsModel: model
        ) { [weak self] (changed: Set<CurrencyId>) in
            self?.updateSoldCurrency(changed: changed)
        }
    }

    func editButtonTapped() {
        guard let model = symbolsModel else { return }
        router.openSelectionCurrencyList(
            currencyList: purchasedCurrencyList,
            symbolsModel: model
        ) { [weak self] (changed: Set<CurrencyId>) in
            self?.updatePurchasedCurrenciesList(changed: changed)
        }
    }
}

private extension ConverterCurrencyPresenter {
    func updateSoldCurrency(changed: Set<CurrencyId>) {
        guard let element = changed.first else { return }
        soldCurrency = element
    }

    func updatePurchasedCurrenciesList(changed: Set<CurrencyId>) {
        purchasedCurrencyList = Array(changed.sorted(by: { $0 < $1 }))
    }

    func createSoldCurrencyModel(currencyID: CurrencyId) -> ConverterCurrencyView.SoldCurrencyModel {
        let flag = UIImage(named: currencyID)
        let model: ConverterCurrencyView.SoldCurrencyModel
        if let currencyName = symbolsModel?.symbols[currencyID] {
            model = .init(flag: flag, currencyKey: currencyID, currencyName: currencyName)
        } else {
            model = .init(flag: .NONE, currencyKey: "Click to select currency", currencyName: "")
        }
        return model
    }

    func createPurchasedCurrenciesModels() -> [ConverterCurrencyTableViewCell.Model] {
        guard purchasedCurrencyList.count > 0 else {
//            view?.showEmpty()
            return [ConverterCurrencyTableViewCell.Model]()
        }
        var models = [ConverterCurrencyTableViewCell.Model]()

        for element in purchasedCurrencyList {
            let flag = UIImage(named: element)
            let key = element
            let name = symbolsModel?.symbols.first(where: { $0.key == element })?.value ?? ""
            let rate = isRequestNeeded ? 0.0 : ratesModel?.rates.first(where: { $0.key == element })?.value ?? 0.0
            let amount = isRequestNeeded ? 0.0 : (Double(soldCurrencyModel.amount) ?? 0) * rate

            let item: ConverterCurrencyTableViewCell.Model = .init(
                baseCurrency: soldCurrency,
                flag: flag,
                currencyKey: key,
                currencyName: name,
                amount: String(format: "%.\(amountDecimals)f", amount),
                rate: "1 \(soldCurrency) = \(String(format: "%.\(rateDecimals)f", rate)) \(key)"
            )
            models.append(item)
        }
        return models
    }

    func updateTablePurchasedCurrencies() {
        let models = createPurchasedCurrenciesModels()
        let viewModel = ConverterCurrencyView.Model(items: models)

        var dateString = "unknown"
        if let lastUpdate = ratesModel?.date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            dateString = dateFormatter.string(from: lastUpdate)
        }

        view?.updateTablePurchasedCurrencies(
            model: viewModel,
            lastDateReceivedData: "Last update: \(dateString)"
        )
    }

    func updateRatesCurrencies() {
        ratesService.fetchRates(
            base: soldCurrency,
            symbols: purchasedCurrencyList,
            queue: .main
        ) { [self] result in

            switch result {
            case let .success(data):
                ratesModel = data
                isRequestNeeded = false
            case let .failure(error):
                print(error)
            }
            updateTablePurchasedCurrencies()
        }
    }
}
