import UIKit

final class ConverterCurrencyFactory {
    func make() -> UIViewController {
        let networkClient = NetworkClient()
        let symbolsService = SymbolsDemoService()
        let ratesService = RatesDemoService()
//        let symbolsService = SymbolsService(networkClient: networkClient)
//        let ratesService = RatesService(networkClient: networkClient)

        let router = ConverterCurrencyRouter(
            factory: SelectionCurrencyFactory()
        )

        let presenter = ConverterCurrencyPresenter(
            soldCurrency: Settings.soldCurrency,
            purchasedCurrencyList: Settings.purchasedCurrencyList,
            rateDecimals: Settings.rateDecimals,
            amountDecimals: Settings.amountDecimals,
            symbolsService: symbolsService,
            ratesService: ratesService,
            router: router
        )
        let vc = ConverterCurrencyViewController(presenter: presenter)

        presenter.view = vc
        router.setRootViewController(root: vc)

        return vc
    }
}
