import UIKit

final class SelectionCurrencyFactory {
    func makeCurrencyVC(currencyKey: CurrencyId, symbolsModel: SymbolsModel, completion: @escaping (CurrencyId) -> Void) -> UIViewController {
        /// Только Factory может наполнять Presenter реальными сервисами и другими зависимостями

        let presenter = SelectionCurrencyPresenter(
            symbolsModel: symbolsModel,
            soldCurrency: currencyKey,
            isSingleCellSelectionMode: true
        )
        let vc = SelectionCurrencyViewController(presenter: presenter)

        presenter.view = vc
        presenter.completionCurrency = completion

        return vc
    }

    func makeListVC(currencyList: [CurrencyId], symbolsModel: SymbolsModel, completion: @escaping ([CurrencyId]) -> Void) -> UIViewController {
        /// Только Factory может наполнять Presenter реальными сервисами и другими зависимостями
        let networkClient = NetworkClient() // FIXME: убрать

        let presenter = SelectionCurrencyPresenter(
            symbolsModel: symbolsModel,
            purchasedCurrenciesList: currencyList,
            isSingleCellSelectionMode: false
        )
        let vc = SelectionCurrencyViewController(presenter: presenter)

        presenter.view = vc
        presenter.completionList = completion

        return vc
    }
}
