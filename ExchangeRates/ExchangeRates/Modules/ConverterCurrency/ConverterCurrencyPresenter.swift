import UIKit

protocol ConverterCurrencyPresenterProtocol {
    var title: String { get }
    func viewDidLoad()
    func showConvertibleCurrencyVCTapButton()
    func showCurrencyListVCTapButton()
    func getAmountConvertibleCurrency(text: String)
}

final class ConverterCurrencyPresenter: ConverterCurrencyPresenterProtocol {
    weak var view: ConverterCurrencyViewProtocol?

    private let networkClient: NetworkClientProtocol
    private let router: ConverterCurrencyRouterProtocol

    private lazy var convertibleCurrency = createCurrencyModel(currencyID: "AED", currencyValue: "United Arab Emirates Dirham")

    private var sourceCurrencyList = ["AFN": "Afghan Afghani", "AMD": "Armenian Dram"]
    private lazy var currencyList = createCurrencyListModel(currencies: sourceCurrencyList)

    var title: String { "Currencies" }

    init(
        networkClient: NetworkClientProtocol,
        router: ConverterCurrencyRouterProtocol
    ) {
        self.networkClient = networkClient
        self.router = router
    }

//    func response(base: String, symbols: [String]) {
//        view?.stopLoader()
//        let ratesService = RatesService(networkClient: networkClient)
//        ratesService.fetchRates(base: base, symbols: symbols) { result in
//            switch result {
//            case let .success(model):
//                print(model)
//            case let .failure(error):
//                print(error)
//            }
//        }
//    }

    func viewDidLoad() {
        view?.updateConvertibleCurrency(model: convertibleCurrency)
        view?.updateListExchangeCurrencies(model: currencyList)
        print(sourceCurrencyList.keys)

//        let dsfg: Dictionary<String, String>.Keys.
    }

    private func createCurrencyModel(currencyID: CurrencyId, currencyValue: String) -> ConverterCurrencyView.ConvertibleCurrencyModel {
        let flag = UIImage(named: currencyID)
        let model: ConverterCurrencyView.ConvertibleCurrencyModel = .init(flag: flag, currencyKey: currencyID, currencyName: currencyValue)
        return model
    }

    func getAmountConvertibleCurrency(text: String) {
        if let amount = Double(text) {
            convertibleCurrency.amount = amount
            view?.updateConvertibleCurrency(model: convertibleCurrency)
        } else {
            print("incorrect number")
        }
    }

    private func createCurrencyListModel(currencies: [CurrencyId: String]) -> ConverterCurrencyView.ConvertibleCurrencyListModel {
        var items: [ConverterCurrencyView.ConvertibleCurrencyListModel.Item] = []
        for element in currencies {
            let flag = UIImage(named: element.key)
            let item: ConverterCurrencyView.ConvertibleCurrencyListModel.Item = .init(flag: flag, currencyKey: element.key, currencyName: element.value)
            items.append(item)
        }
        let model: ConverterCurrencyView.ConvertibleCurrencyListModel = .init(items: items.sorted(by: { $0.currencyKey < $1.currencyKey }))
        return model
    }

    private func updateConvertibleCurrency(currencyKey: CurrencyId, currencyName: String) {
        let model = createCurrencyModel(currencyID: currencyKey, currencyValue: currencyName)
        convertibleCurrency = model
        view?.updateConvertibleCurrency(model: model)
    }

    func updateListExchangeCurrencies(model: [CurrencyId: String]) {
        sourceCurrencyList = model
        let model = createCurrencyListModel(currencies: model)
        currencyList = model
        view?.updateListExchangeCurrencies(model: model)
    }

    //
    func showConvertibleCurrencyVCTapButton() {
        // открыть модуль Beta и передать туда параметры
        router.openSelectionCurrency(currencyKey: convertibleCurrency.currencyKey, completion: updateConvertibleCurrency(currencyKey:currencyName:))
    }

    func showCurrencyListVCTapButton() {
        // открыть модуль Beta и передать туда параметры
        router.openSelectionCurrencyList(currencyList: sourceCurrencyList, completion: updateListExchangeCurrencies(model:))
    }
}
