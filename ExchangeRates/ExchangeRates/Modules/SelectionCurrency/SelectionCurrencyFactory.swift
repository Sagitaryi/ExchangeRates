import UIKit

final class SelectionCurrencyFactory {
    struct Context {
        let someParam: String
        let someValue: Int
    }

    func make() -> UIViewController {
        /// Только Factory может наполнять Presenter реальными сервисами и другими зависимостями
        let networkClient = NetworkClient()

        let router = SelectionCurrencyRouter(
            factory: SelectionCurrencyFactory()
        )

        let presenter = SelectionCurrencyPresenter(
            networkClient: networkClient,
            router: router
        )
        let vc = SelectionCurrencyViewController(presenter: presenter)

        presenter.view = vc
//        router.setRootViewController(root: vc)

        return vc
    }
}
