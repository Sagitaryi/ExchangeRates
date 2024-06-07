import UIKit

final class ModuleSelectionCurrencyFactory {
    struct Context {
        let someParam: String
        let someValue: Int
    }

    func make() -> UIViewController {
        /// Только Factory может наполнять Presenter реальными сервисами и другими зависимостями
        let networkClient = NetworkClient()

        let router = ModuleSelectionCurrencyRouter(
            factory: ModuleSelectionCurrencyFactory()
        )

        let presenter = ModuleSelectionCurrencyPresenter(
            networkClient: networkClient,
            router: router
        )
        let vc = ModuleSelectionCurrencyViewController(presenter: presenter)

        presenter.view = vc
        router.setRootViewController(root: vc)

        return vc
    }
}
