import UIKit

final class ConverterCurrencyFactory {
    func make() -> UIViewController {
        /// Только Factory может наполнять Presenter реальными сервисами и другими зависимостями
        let networkClient = NetworkClient()
        let ratesService = RatesService(networkClient: networkClient)

        let router = ConverterCurrencyRouter(
            factory: SelectionCurrencyFactory()
        )

        let presenter = ConverterCurrencyPresenter(
            ratesService: ratesService,
            router: router
        )
        let vc = ConverterCurrencyViewController(presenter: presenter)

        presenter.view = vc
        router.setRootViewController(root: vc)

        return vc
    }
}
