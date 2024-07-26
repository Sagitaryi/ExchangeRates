import UIKit

final class SelectionCurrencyFactory {
    struct Context {
        let someParam: String
        let someValue: Int
    }

    func makeCurrencyVC(currency: ConvertibleCurrencyModel?, completion: @escaping (ConvertibleCurrencyModel) -> Void) -> UIViewController {
        /// Только Factory может наполнять Presenter реальными сервисами и другими зависимостями
        let networkClient = NetworkClient()

        let router = SelectionCurrencyRouter(
            factory: SelectionCurrencyFactory()
        )

        let presenter = SelectionCurrencyPresenter(
            networkClient: networkClient,
            router: router,
            convertibleCurrency: currency,
            isSingleCellSelectionMode: true
        )
        let vc = SelectionCurrencyViewController(presenter: presenter)

        presenter.view = vc
        presenter.completionCurrency = completion

        return vc
    }

    func makeListVC(currencyList: [ConvertibleCurrencyModel?]?, completion: @escaping ([ConvertibleCurrencyModel]) -> Void) -> UIViewController {
        /// Только Factory может наполнять Presenter реальными сервисами и другими зависимостями
        let networkClient = NetworkClient()

        let router = SelectionCurrencyRouter(
            factory: SelectionCurrencyFactory()
        )

        let presenter = SelectionCurrencyPresenter(
            networkClient: networkClient,
            router: router,
            convertibleCurrencyList: currencyList,
            isSingleCellSelectionMode: false
        )
        let vc = SelectionCurrencyViewController(presenter: presenter)

        presenter.view = vc
        presenter.completionList = completion

        return vc
    }
}
