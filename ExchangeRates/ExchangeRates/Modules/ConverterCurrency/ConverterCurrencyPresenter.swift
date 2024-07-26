import UIKit

protocol ConverterCurrencyPresenterProtocol {
    var title: String { get }
//
    func viewDidLoad()
    func showConvertibleCurrencyVCTapButton()
    func showCurrencyListVCTapButton()
}

final class ConverterCurrencyPresenter: ConverterCurrencyPresenterProtocol {
    weak var view: ConverterCurrencyViewProtocol?

    private let networkClient: NetworkClientProtocol
    private let router: ConverterCurrencyRouterProtocol

    private var convertibleCurrency: ConvertibleCurrencyModel?
    private var currencyList: [ConvertibleCurrencyModel?]?

    var startingCurrencyModel: SymbolsModel = .init(symbols: ["AED": "United Arab Emirates Dirham"])

    var title: String { "Currencies" }

    init(
        networkClient: NetworkClientProtocol,
        router: ConverterCurrencyRouterProtocol
    ) {
        self.networkClient = networkClient
        self.router = router
    }

    func response(base: String, symbols: [String]) {
//                view?.stopLoader()
        let ratesService = RatesService(networkClient: networkClient)
        ratesService.fetchRates(base: base, symbols: symbols) { result in
            switch result {
            case let .success(model):
                print(model)
            case let .failure(error):
                print(error)
            }
        }
    }

    func viewDidLoad() {
        convertibleCurrency = .init(model: startingCurrencyModel)
        view?.updateConvertibleCurrency(model: convertibleCurrency)
    }

    func updateConvertibleCurrency(model: ConvertibleCurrencyModel?) {
        view?.updateConvertibleCurrency(model: model)
    }

    func updateListExchangeCurrencies(model: [ConvertibleCurrencyModel]) {
        view?.updateListExchangeCurrencies(model: model)
    }

//
    func showConvertibleCurrencyVCTapButton() {
        // открыть модуль Beta и передать туда параметры
        router.openSelectionCurrency(currency: convertibleCurrency, completion: updateConvertibleCurrency(model:))
    }

    func showCurrencyListVCTapButton() {
        // открыть модуль Beta и передать туда параметры
        router.openSelectionCurrencyList(currencyList: currencyList, completion: updateListExchangeCurrencies(model:))
    }
}
