import UIKit

// Роутер, который открывает все переходы с модуля Alpha
protocol ConverterCurrencyRouterProtocol: AnyObject {
    // Модуль Alpha показывает модуль Beta и передает в него параметры.
    func openSelectionCurrency(currency: ConvertibleCurrencyModel?,
                               completion: @escaping (ConvertibleCurrencyModel) -> Void)
    func openSelectionCurrencyList(currencyList: [ConvertibleCurrencyModel?]?,
                                   completion: @escaping ([ConvertibleCurrencyModel]) -> Void)
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
    func openSelectionCurrency(currency: ConvertibleCurrencyModel?,
                               completion: @escaping (ConvertibleCurrencyModel) -> Void)
    {
        let viewController = factory.makeCurrencyVC(currency: currency, completion: completion)
        root?.navigationController?.pushViewController(viewController, animated: true)
    }

    func openSelectionCurrencyList(currencyList: [ConvertibleCurrencyModel?]?,
                                   completion: @escaping ([ConvertibleCurrencyModel]) -> Void)
    {
        let viewController = factory.makeListVC(currencyList: currencyList, completion: completion)
        root?.navigationController?.pushViewController(viewController, animated: true)
    }
}
