import UIKit

protocol SelectionCurrencyRouterProtocol: AnyObject {}

final class SelectionCurrencyRouter: SelectionCurrencyRouterProtocol {
    private let factory: SelectionCurrencyFactory

    private weak var root: UIViewController?

    init(factory: SelectionCurrencyFactory) {
        self.factory = factory
    }

    func setRootViewController(root: UIViewController) {
        self.root = root
    }
}
