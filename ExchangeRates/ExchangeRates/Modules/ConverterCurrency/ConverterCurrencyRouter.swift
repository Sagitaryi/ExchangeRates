import UIKit

// Роутер, который открывает все переходы с модуля Alpha
protocol ConverterCurrencyRouterProtocol: AnyObject {
    // Модуль Alpha показывает модуль Beta и передает в него параметры.
    func openSelectionCurrency(with param: String)
}

final class ConverterCurrencyRouter: ConverterCurrencyRouterProtocol {
    private let factory: SelectionCurrencyFactory

    private weak var root: UIViewController?

    init(factory: SelectionCurrencyFactory) {
        self.factory = factory
    }

    func setRootViewController(root: UIViewController) {
        self.root = root
    }

//     Модуль Alpha показывает модуль Beta и передает в него параметры.
    func openSelectionCurrency(with param: String) {
        let context = SelectionCurrencyFactory.Context(
            someParam: param,
            someValue: 100
        )

        let viewController = factory.make()
        root?.navigationController?.pushViewController(viewController, animated: true)
    }
}
