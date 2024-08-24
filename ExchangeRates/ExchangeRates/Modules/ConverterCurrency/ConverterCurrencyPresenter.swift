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

    private let ratesService: RatesServiceProtocol
    private let router: ConverterCurrencyRouterProtocol

    private lazy var soldCurrency = createSoldCurrencyModel(currencyID: "RUB", currencyValue: "Russian Ruble")

    private var sourcePurchasedCurrencyList = ["EUR": "Euro", "USD": "United States Dollar", "KZT": "Kazakhstani Tenge"]
    private lazy var listPurchasedCurrencies = createPurchasedCurrenciesListModel(currencies: sourcePurchasedCurrencyList)

    init(
        ratesService: RatesServiceProtocol,
        router: ConverterCurrencyRouterProtocol
    ) {
        self.ratesService = ratesService
        self.router = router
    }

    func viewDidLoad() {
        view?.startLoader()
        //        let dg = DispatchGroup()
        //        dg.enter()
        //
        //        s1.req { xxx
        //
        //            dg.leave()
        //        }
        //
        //
        //        dg.enter()
        //        s2.req { yyy
        //
        //            dg.leave()
        //        }
        //
        //
        //        dg.notify(queue: .main) {
        //
        //        }

        view?.updateSoldCurrency(model: soldCurrency)
        view?.updateListPurchasedCurrencies(model: listPurchasedCurrencies)
    }

    func updateAmount(text: String) {
        if let amount = Double(text) {
            soldCurrency.amount = String(amount) // !!!
            view?.updateSoldCurrency(model: soldCurrency)
            updateRate()
        } else {
            print("incorrect number")
        }
    }

    //
    func soldCurrencyTapped() {
        router.openSelectionCurrency(currencyKey: soldCurrency.currencyKey, completion: updateSoldCurrency(currencyKey:currencyName:))
    }

    func editButtonTapped() {
        router.openSelectionCurrencyList(currencyList: sourcePurchasedCurrencyList, completion: updatePurchasedCurrenciesList(model:))
    }
}

private extension ConverterCurrencyPresenter {
    func updatePurchasedCurrenciesList(model: [CurrencyId: String]) {
        sourcePurchasedCurrencyList = model
        let model = createPurchasedCurrenciesListModel(currencies: model)
        listPurchasedCurrencies = model
        view?.updateListPurchasedCurrencies(model: model)
    }

    func updateRate() {
        ratesService.fetchRates(base: soldCurrency.currencyKey, symbols: Array(sourcePurchasedCurrencyList.keys), queue: .main) { result in
            switch result {
            case let .success(model):
                self.listPurchasedCurrencies.lastDateReceivedData = model.date
                for element in model.rates {
                    if let index = self.listPurchasedCurrencies.items.firstIndex(where: { $0.currencyKey == element.key }) {
                        self.listPurchasedCurrencies.items[index].rate = element.value
                        self.listPurchasedCurrencies.items[index].amount = (Double(self.soldCurrency.amount) ?? 0) * element.value // !!!
                    }
                }
                self.view?.updateListPurchasedCurrencies(model: self.listPurchasedCurrencies)
            case let .failure(error):
                print(error)
            }
        }
    }

    func createSoldCurrencyModel(currencyID: CurrencyId, currencyValue: String) -> ConverterCurrencyView.SoldCurrencyModel {
        let flag = UIImage(named: currencyID)
        let model: ConverterCurrencyView.SoldCurrencyModel = .init(flag: flag, currencyKey: currencyID, currencyName: currencyValue)
        return model
    }

//    func updateAmountSoldCurrency(text: String, isRequestNeeded: Bool) {
//        if let amount = Double(text) {
//            soldCurrency.amount = String(amount) // !!!
//            view?.updateSoldCurrency(model: soldCurrency)
//            if isRequestNeeded {
//                updateRate()
//            }
//        } else {
//            print("incorrect number")
//        }
//    }

    func createPurchasedCurrenciesListModel(currencies: [CurrencyId: String]) -> ConverterCurrencyView.ListPurchasedCurrenciesModel {
        var items: [ConverterCurrencyView.ListPurchasedCurrenciesModel.Item] = []
        for element in currencies {
            let flag = UIImage(named: element.key)
            let item: ConverterCurrencyView.ListPurchasedCurrenciesModel.Item = .init(flag: flag, currencyKey: element.key, currencyName: element.value)
            items.append(item)
        }
        let model: ConverterCurrencyView.ListPurchasedCurrenciesModel = .init(items: items.sorted(by: { $0.currencyKey < $1.currencyKey }))
        return model
    }

    func updateSoldCurrency(currencyKey: CurrencyId, currencyName: String) {
        let model = createSoldCurrencyModel(currencyID: currencyKey, currencyValue: currencyName)
        soldCurrency = model
        view?.updateSoldCurrency(model: model)
        clearRateAndAmountFields()
    }

    func clearRateAndAmountFields() {
        for element in listPurchasedCurrencies.items {
            if let index = listPurchasedCurrencies.items.firstIndex(where: { $0.currencyKey == element.currencyKey }) {
                listPurchasedCurrencies.items[index].rate = 0
                listPurchasedCurrencies.items[index].amount = 0
            }
        }
        view?.updateListPurchasedCurrencies(model: listPurchasedCurrencies)
    }
}
