import UIKit

final class SelectionCurrencyFactory {
    func makeCurrencyVC(currencyKey: CurrencyId, symbolsModel: SymbolsModel, completion: @escaping (Set<CurrencyId>) -> Void) -> UIViewController {
        /// Только Factory может наполнять Presenter реальными сервисами и другими зависимостями

        let presenter = SelectionCurrencyPresenter(
            selected: [currencyKey],
            symbolsModel: symbolsModel,
            isSingleCellSelectionMode: true
        )
        let vc = SelectionCurrencyViewController(presenter: presenter)

        presenter.view = vc
        presenter.onChanged = completion

        return vc
    }

    func makeListVC(currencyList: [CurrencyId], symbolsModel: SymbolsModel, completion: @escaping (Set<CurrencyId>) -> Void) -> UIViewController {
        /// Только Factory может наполнять Presenter реальными сервисами и другими зависимостями
        let networkClient = NetworkClient() // FIXME: убрать

        let presenter = SelectionCurrencyPresenter(
            selected: Set(currencyList.map { $0 }),
            symbolsModel: symbolsModel,
            isSingleCellSelectionMode: false
        )
        let vc = SelectionCurrencyViewController(presenter: presenter)

        presenter.view = vc
        presenter.onChanged = completion

        return vc
    }
}
