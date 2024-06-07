import UIKit

final class ModuleConverterCurrencyFactory {
    func make() -> UIViewController {
        /// Только Factory может наполнять Presenter реальными сервисами и другими зависимостями
        let networkClient = NetworkClient()

        let router = ModuleConverterCurrencyRouter(
            factory: ModuleSelectionCurrencyFactory()
        )

        let presenter = ModuleConverterCurrencyPresenter(
            networkClient: networkClient,
            router: router
        )
        let vc = ModuleConverterCurrencyViewController(presenter: presenter)

        presenter.view = vc
        router.setRootViewController(root: vc)

        return vc
    }
}
