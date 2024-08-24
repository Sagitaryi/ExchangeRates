import UIKit

final class SelectionCurrencyFactory {
    func makeCurrencyVC(currencyKey: CurrencyId, completion: @escaping (String, String) -> Void) -> UIViewController {
        /// Только Factory может наполнять Presenter реальными сервисами и другими зависимостями
        let networkClient = NetworkClient() // FIXME: убрать

        let presenter = SelectionCurrencyPresenter(
            networkClient: networkClient, // FIXME: убрать
            convertibleCurrency: currencyKey,
            isSingleCellSelectionMode: true
        )
        let vc = SelectionCurrencyViewController(presenter: presenter)

        presenter.view = vc
        presenter.completionCurrency = completion

        return vc
    }

    func makeListVC(currencyList: [CurrencyId: String], completion: @escaping ([CurrencyId: String]) -> Void) -> UIViewController {
        /// Только Factory может наполнять Presenter реальными сервисами и другими зависимостями
        let networkClient = NetworkClient() // FIXME: убрать

        let presenter = SelectionCurrencyPresenter(
            networkClient: networkClient, // FIXME: убрать
            convertibleCurrencyList: currencyList,
            isSingleCellSelectionMode: false
        )
        let vc = SelectionCurrencyViewController(presenter: presenter)

        presenter.view = vc
        presenter.completionList = completion

        return vc
    }
}
