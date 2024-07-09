import UIKit

final class ConverterCurrencyFactory {
    func make() -> UIViewController {
        /// Только Factory может наполнять Presenter реальными сервисами и другими зависимостями
        let networkClient = NetworkClient()

        let router = ConverterCurrencyRouter(
            factory: SelectionCurrencyFactory()
        )

        let presenter = ConverterCurrencyPresenter(
            networkClient: networkClient,
            router: router
        )
        let vc = ConverterCurrencyViewController(presenter: presenter)

        presenter.view = vc
        router.setRootViewController(root: vc)

        return vc
    }
}
