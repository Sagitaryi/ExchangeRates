import UIKit

protocol SelectionCurrencyPresenterProtocol {
    var title: String { get }
    var completionCurrency: ((ConvertibleCurrencyModel) -> Void)? { get }
    var completionList: (([ConvertibleCurrencyModel]) -> Void)? { get }
    func viewDidLoad()
    func tapCell(index: Int)
}

final class SelectionCurrencyPresenter: SelectionCurrencyPresenterProtocol {
    weak var view: SelectionCurrencyViewProtocol?

    private let networkClient: NetworkClientProtocol
    private let router: SelectionCurrencyRouterProtocol
    private var model: SelectionCurrencyView.Model?
    private var convertibleCurrency: ConvertibleCurrencyModel?
    private var convertibleCurrencyList: [ConvertibleCurrencyModel?]?
    private let isSingleCellSelectionMode: Bool
    var completionCurrency: ((ConvertibleCurrencyModel) -> Void)?
    var completionList: (([ConvertibleCurrencyModel]) -> Void)?

    var title: String { "Add currency" }

    init(
        networkClient: NetworkClientProtocol,
        router: SelectionCurrencyRouterProtocol,
        convertibleCurrency: ConvertibleCurrencyModel? = nil,
        convertibleCurrencyList: [ConvertibleCurrencyModel?]? = nil,
        isSingleCellSelectionMode: Bool
    ) {
        self.networkClient = networkClient
        self.router = router
        self.convertibleCurrency = convertibleCurrency
        self.convertibleCurrencyList = convertibleCurrencyList
        self.isSingleCellSelectionMode = isSingleCellSelectionMode
    }

    func viewDidLoad() {
        view?.stopLoader()
        view?.updateStateSingleCellSelectionMode(state: isSingleCellSelectionMode ?? false)
        let symbolsService = SymbolsService(networkClient: networkClient)
        symbolsService.fetchSymbols { [self] result in
            view?.stopLoader()
            switch result {
            case let .success(data):
                let model: SelectionCurrencyView.Model = .init(items: createModelItem(symbolsModel: data))
                self.model = model
                view?.update(model: model)
            case let .failure(error):
                print(error)
            }
//            singleTapCell()
        }
    }

    private func createModelItem(symbolsModel: SymbolsModel) -> [Item] {
        var items: [Item] = []
        for currency in Array(symbolsModel.symbols).sorted(by: { $0.0 < $1.0 }) {
            items.append(Item(key: currency.key, value: currency.value, isSelected: false))
        }
        return items
    }

    func tapCell(index: Int) {
        guard var model = model else { return }
        print(isSingleCellSelectionMode)

        if isSingleCellSelectionMode {
            guard let previousIndex = model.items.firstIndex(where: { $0.isSelected == true }) else { return }
            model.items[previousIndex].isSelected = false
            model.items[index].isSelected = true
            self.model = model
            completionCurrency?(convertibleCurrency!)
        } else {
            let isSelected = model.items[index].isSelected
            model.items[index].isSelected = !isSelected
            self.model = model

            convertibleCurrency = .init(model: SymbolsModel(symbols: [model.items[index].key: model.items[index].value]))
            completionCurrency?(convertibleCurrency!)
        }
        view?.update(model: model)
    }

//    func singleTapCell() {
//        guard var model = model else { return }
//        for element in 0 ..< model.items.count {
//            model.items[element].isSelected = false
//        }
//        guard let index = model.items.firstIndex(where: { $0.key == convertibleCurrency?.key }) else { return }
//        model.items[index].isSelected = true
//        self.model = model
//        view?.update(model: model)
//    }
}
