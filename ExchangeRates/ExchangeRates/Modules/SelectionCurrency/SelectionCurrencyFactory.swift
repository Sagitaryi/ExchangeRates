import UIKit

final class SelectionCurrencyFactory {
    func makeCurrencyVC(currencyKey: CurrencyId, symbolsModel: SymbolsModel, completion: @escaping (Set<CurrencyId>) -> Void) -> UIViewController {
        let presenter = SelectionCurrencyPresenter(
            selected: [currencyKey],
            symbolsModel: symbolsModel,
            onChanged: completion,
            isSingleCellSelectionMode: true
        )
        let vc = SelectionCurrencyViewController(presenter: presenter)

        presenter.view = vc

        return vc
    }

    func makeListVC(currencyList: [CurrencyId], symbolsModel: SymbolsModel, completion: @escaping (Set<CurrencyId>) -> Void) -> UIViewController {
        let presenter = SelectionCurrencyPresenter(
            selected: Set(currencyList.map { $0 }),
            symbolsModel: symbolsModel,
            onChanged: completion,
            isSingleCellSelectionMode: false
        )
        let vc = SelectionCurrencyViewController(presenter: presenter)

        presenter.view = vc

        return vc
    }
}
