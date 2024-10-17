import UIKit

protocol ConverterCurrencyRouterProtocol: AnyObject {
    func openSelectionCurrency(currencyKey: CurrencyId, symbolsModel: SymbolsModel,
                               completion: @escaping ((Set<CurrencyId>) -> Void))
    func openSelectionCurrencyList(currencyList: [CurrencyId], symbolsModel: SymbolsModel,
                                   completion: @escaping ((Set<CurrencyId>) -> Void))
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

    func openSelectionCurrency(currencyKey: CurrencyId, symbolsModel: SymbolsModel,
                               completion: @escaping ((Set<CurrencyId>) -> Void))
    {
        let viewController = factory.makeCurrencyVC(
            currencyKey: currencyKey,
            symbolsModel: symbolsModel,
            completion: completion
        )
        root?.navigationController?.pushViewController(viewController, animated: true)
    }

    func openSelectionCurrencyList(currencyList: [CurrencyId], symbolsModel: SymbolsModel,
                                   completion: @escaping ((Set<CurrencyId>) -> Void))
    {
        let viewController = factory.makeListVC(
            currencyList: currencyList,
            symbolsModel: symbolsModel,
            completion: completion
        )
        root?.navigationController?.pushViewController(viewController, animated: true)
    }
}
