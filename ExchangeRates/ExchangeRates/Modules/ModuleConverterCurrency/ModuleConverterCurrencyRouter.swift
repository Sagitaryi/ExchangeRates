import UIKit

// Роутер, который открывает все переходы с модуля Alpha
protocol ModuleConverterCurrencyRouterProtocol: AnyObject {
    // Модуль Alpha показывает модуль Beta и передает в него параметры.
    func openModuleSelectionCurrency(with param: String)
}

final class ModuleConverterCurrencyRouter: ModuleConverterCurrencyRouterProtocol {
    private let factory: ModuleSelectionCurrencyFactory

    private weak var root: UIViewController?

    init(factory: ModuleSelectionCurrencyFactory) {
        self.factory = factory
    }

    func setRootViewController(root: UIViewController) {
        self.root = root
    }

//     Модуль Alpha показывает модуль Beta и передает в него параметры.
    func openModuleSelectionCurrency(with param: String) {
        let context = ModuleSelectionCurrencyFactory.Context(
            someParam: param,
            someValue: 100
        )

        let viewController = factory.make()
        root?.navigationController?.pushViewController(viewController, animated: true)
    }
}
