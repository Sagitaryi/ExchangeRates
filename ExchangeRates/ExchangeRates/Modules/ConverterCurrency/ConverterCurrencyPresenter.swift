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

    private var soldCurrencyModel: ConverterCurrencyView.SoldCurrencyModel = .init(currencyKey: "", currencyName: "")
    private var purchasedCurrencyListModel: ConverterCurrencyView.ListPurchasedCurrenciesModel = .init(items: [])

    private let symbolsService: SymbolsServiceProtocol
    private let ratesService: RatesServiceProtocol
    private let tableManager: TableManagerServiceProtocol = TableManagerService()
    private let router: ConverterCurrencyRouterProtocol

    private let rateDecimals: String
    private let amountDecimals: String

    private var soldCurrency: CurrencyId {
        didSet {
            if oldValue != soldCurrency {
                clearRateAndAmountFields()
                soldCurrencyModel = createSoldCurrencyModel(currencyID: soldCurrency)
                view?.updateSoldCurrency(model: soldCurrencyModel)
                isRequestNeeded = true
            }
        }
    }

    private var purchasedCurrencyList: [CurrencyId] {
        didSet {
            if oldValue != purchasedCurrencyList {
                clearRateAndAmountFields()
                updateRateModel()
                purchasedCurrencyListModel = createPurchasedCurrenciesListModel(purchasedCurrencyList: purchasedCurrencyList)
                view?.updateListPurchasedCurrencies(model: purchasedCurrencyListModel)
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
            view?.stopLoader() // FIXME: проверить расположение
            soldCurrencyModel = createSoldCurrencyModel(currencyID: soldCurrency)
            purchasedCurrencyListModel = createPurchasedCurrenciesListModel(purchasedCurrencyList: purchasedCurrencyList)
            view?.updateSoldCurrency(model: soldCurrencyModel)
            view?.updateListPurchasedCurrencies(model: purchasedCurrencyListModel)
            updateTableView()
        }
    }

    func updateTableView() {
        let tableView = UITableView()
        tableView.backgroundColor = .red
        tableManager.attachTable(tableView)
        var modelsViewCell: [ConverterCurrencyTableViewCell.Model] = []
        for item in purchasedCurrencyListModel.items {
            modelsViewCell.append(.init(baseCurrency: soldCurrency, flag: item.flag, currencyKey: item.currencyKey, currencyName: item.currencyName, amount: item.amount, rate: item.rate))
        }
        print("modelsViewCell - \(modelsViewCell)")
        tableManager.displayConverterCurrencyTableView(modelsViewCell: modelsViewCell)
        view?.updateTableView(table: tableView)
    }

    func updateAmount(text: String) {
        if let amount = Double(text) {
            soldCurrencyModel.amount = String(amount)
            if isRequestNeeded {
                updateRateModel()
            }
            purchasedCurrencyListModel = createPurchasedCurrenciesListModel(purchasedCurrencyList: purchasedCurrencyList)
            view?.updateListPurchasedCurrencies(model: purchasedCurrencyListModel)
        } else {
            print("incorrect number")
        }
    }

    func soldCurrencyTapped() {
        guard let model = symbolsModel else { return }
        router.openSelectionCurrency(currencyKey: soldCurrency, symbolsModel: model, completion: updateSoldCurrency(onChanged:))
    }

    func editButtonTapped() {
        guard let model = symbolsModel else { return }
        router.openSelectionCurrencyList(currencyList: purchasedCurrencyList, symbolsModel: model, completion: updatePurchasedCurrenciesList(onChanged:))
    }
}

private extension ConverterCurrencyPresenter {
    func updateSoldCurrency(onChanged: Set<CurrencyId>) {
        guard let element = onChanged.first else { return }
        soldCurrency = element
    }

    func updatePurchasedCurrenciesList(onChanged: Set<CurrencyId>) {
        purchasedCurrencyList = Array(onChanged.sorted(by: { $0 < $1 }))
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

    func createPurchasedCurrenciesListModel(purchasedCurrencyList: [CurrencyId]) -> ConverterCurrencyView.ListPurchasedCurrenciesModel {
        var model: ConverterCurrencyView.ListPurchasedCurrenciesModel = .init(items: [])
        for element in purchasedCurrencyList {
            let flag = UIImage(named: element)
            let key = element
            let name = symbolsModel?.symbols.first(where: { $0.key == element })?.value ?? ""
            let rate = ratesModel?.rates.first(where: { $0.key == element })?.value ?? 0.0
            let amount = (Double(soldCurrencyModel.amount) ?? 0) * rate
            let item: ConverterCurrencyView.ListPurchasedCurrenciesModel.Item = .init(flag: flag,
                                                                                      currencyKey: key,
                                                                                      currencyName: name,
                                                                                      amount: String(format: "%.\(amountDecimals)f", amount),
                                                                                      rate: String(format: "%.\(rateDecimals)f", rate))

            model.items.append(item)
        }
        return model
    }

    func updateRateModel() {
        ratesService.fetchRates(base: soldCurrency, symbols: purchasedCurrencyList, queue: .main) { [self] result in
            switch result {
            case let .success(data):
                ratesModel = data
                isRequestNeeded = false
            case let .failure(error):
                print(error)
            }
        }
    }

    func clearRateAndAmountFields() {
        for element in purchasedCurrencyListModel.items {
            soldCurrencyModel.amount = "0"
            if let index = purchasedCurrencyListModel.items.firstIndex(where: { $0.currencyKey == element.currencyKey }) {
                purchasedCurrencyListModel.items[index].rate = "0"
                purchasedCurrencyListModel.items[index].amount = "0"
            }
        }
        view?.updateSoldCurrency(model: soldCurrencyModel)
        view?.updateListPurchasedCurrencies(model: purchasedCurrencyListModel)
    }
}
