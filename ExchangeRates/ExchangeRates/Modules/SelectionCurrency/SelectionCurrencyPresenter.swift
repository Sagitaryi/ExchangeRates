import UIKit

protocol SelectionCurrencyPresenterProtocol {
    var title: String { get }
    func viewDidLoad()
    func tapCell(model: SelectionCurrencyView.Model?, index: Int, cell: SelectionCurrencyTableViewCell)
//    func showNextVCTapButton()
}

final class SelectionCurrencyPresenter: SelectionCurrencyPresenterProtocol {
    weak var view: SelectionCurrencyViewProtocol?

    private let networkClient: NetworkClientProtocol
    private let router: SelectionCurrencyRouterProtocol
    private var model: SelectionCurrencyView.Model?

    var title: String { "Add currency" }

    init(
        networkClient: NetworkClientProtocol,
        router: SelectionCurrencyRouterProtocol
    ) {
        self.networkClient = networkClient
        self.router = router
    }

    func viewDidLoad() {
        view?.stopLoader()
        let symbolsService = SymbolsService(networkClient: networkClient)
        symbolsService.fetchSymbols { [self] result in
            view?.stopLoader()
            switch result {
            case let .success(data):
                let model: SelectionCurrencyView.Model = .init(items: createModelItem(symbolsModel: data))
                view?.update(model: model)
            case let .failure(error):
                print(error)
            }
        }
    }

    private func createModelItem(symbolsModel: SymbolsModel) -> [Item] {
        var items: [Item] = []
        for currency in Array(symbolsModel.symbols).sorted(by: { $0.0 < $1.0 }) {
            items.append(Item(key: currency.key, value: currency.value, isSelected: false))
        }
        return items
    }

    func tapCell(model: SelectionCurrencyView.Model?, index: Int, cell _: SelectionCurrencyTableViewCell) {
        guard var model = model else { return }
        let isSelected = model.items[index].isSelected
        model.items[index].isSelected = !isSelected
        view?.update(model: model)
    }

//    func showNextVCTapButton() {
    // открыть следующий модуль и передать туда параметры
//        router.openSelectionCurrency(with: "sdfs")
//    }
}
