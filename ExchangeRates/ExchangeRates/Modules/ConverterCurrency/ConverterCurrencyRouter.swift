import UIKit

// Роутер, который открывает все переходы с модуля Alpha
protocol ConverterCurrencyRouterProtocol: AnyObject {
    // Модуль Alpha показывает модуль Beta и передает в него параметры.
    func openSelectionCurrency(currencyKey: CurrencyId,
                               completion: @escaping (String, String) -> Void)
    func openSelectionCurrencyList(currencyList: [CurrencyId: String],
                                   completion: @escaping ([CurrencyId: String]) -> Void)
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
    func openSelectionCurrency(currencyKey: CurrencyId,
                               completion: @escaping (String, String) -> Void)
    {
        let viewController = factory.makeCurrencyVC(currencyKey: currencyKey, completion: completion)
        root?.navigationController?.pushViewController(viewController, animated: true)
    }

    func openSelectionCurrencyList(currencyList: [CurrencyId: String],
                                   completion: @escaping ([CurrencyId: String]) -> Void)
    {
        let viewController = factory.makeListVC(currencyList: currencyList, completion: completion)
        root?.navigationController?.pushViewController(viewController, animated: true)
    }
}
