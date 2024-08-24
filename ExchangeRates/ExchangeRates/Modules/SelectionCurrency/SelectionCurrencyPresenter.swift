import UIKit

protocol SelectionCurrencyPresenterProtocol {
    var title: String { get }
    var completionCurrency: ((CurrencyId, String) -> Void)? { get }
    var completionList: (([CurrencyId: String]) -> Void)? { get }
    func viewDidLoad()
    func tapCell(index: Int)
}

final class SelectionCurrencyPresenter: SelectionCurrencyPresenterProtocol {
    weak var view: SelectionCurrencyViewProtocol?

    var title: String { "Add currency" }

    private let networkClient: NetworkClientProtocol // FIXME: убрать после того, как уйдет сервис Symbols

    private var model: SelectionCurrencyView.Model? // TODO:

    private var convertibleCurrency: CurrencyId?
    private var convertibleCurrencyList: [CurrencyId: String]?

    private let isSingleCellSelectionMode: Bool

    private var selected = Set<CurrencyId>()

    var onChanged: ((Set<CurrencyId>) -> Void)?

    var completionCurrency: ((CurrencyId, String) -> Void)?
    var completionList: (([CurrencyId: String]) -> Void)?

    init(
        networkClient: NetworkClientProtocol,
        convertibleCurrency: String? = nil,
        convertibleCurrencyList: [CurrencyId: String]? = nil,
        isSingleCellSelectionMode: Bool
    ) {
        self.networkClient = networkClient
        self.convertibleCurrency = convertibleCurrency
        self.convertibleCurrencyList = convertibleCurrencyList
        self.isSingleCellSelectionMode = isSingleCellSelectionMode
    }

    func viewDidLoad() {
        view?.stopLoader()
        let symbolsService = SymbolsService(networkClient: networkClient) // FIXME: убрать
        symbolsService.fetchSymbols { [self] result in
            view?.stopLoader()
            switch result {
            case let .success(data):
                let resultingModel: SelectionCurrencyView.Model = .init(items: createModelItem(symbolsModel: data))
                let model = indicateSelectedCurrency(resultingModel: resultingModel)
                self.model = model
                view?.update(model: model)
            case let .failure(error):
                print(error) // TODO: Что делать с ошибкой
            }
        }
    }

    func tapCell(index: Int) {
        guard var model = model else { return }
        if isSingleCellSelectionMode {
            guard let previousIndex = model.items.firstIndex(where: { $0.isSelected == true }) else { return }
            model.items[previousIndex].isSelected = false
            model.items[index].isSelected = true
            self.model = model
            convertibleCurrency = model.items[index].currencyKey
            completionCurrency?(model.items[index].currencyKey, model.items[index].currencyName)
        } else {
            let isSelected = model.items[index].isSelected
            model.items[index].isSelected = !isSelected
            self.model = model
            convertibleCurrencyList = model.items.filter { $0.isSelected == true }.reduce(into: [String: String]()) { $0[$1.currencyKey] = $1.currencyName }
            if let currencyList = convertibleCurrencyList {
                completionList?(currencyList)
            }
        }
        view?.update(model: model)
    }
}

private extension SelectionCurrencyPresenter {
    func indicateSelectedCurrency(resultingModel: SelectionCurrencyView.Model) -> SelectionCurrencyView.Model {
        var model = resultingModel
        if isSingleCellSelectionMode {
            let index = model.items.firstIndex(where: { $0.currencyKey == convertibleCurrency })
            if let index = index {
                model.items[index].isSelected = true
            }
        } else {
            if let currencyList = convertibleCurrencyList {
                for element in currencyList.keys {
                    if let index = model.items.firstIndex(where: { $0.currencyKey == element }) {
                        model.items[index].isSelected = true
                    }
                }
            }
        }
        return model
    }

    func createModelItem(symbolsModel: SymbolsModel) -> [Item] {
        var items: [Item] = []
        for currency in Array(symbolsModel.symbols).sorted(by: { $0.0 < $1.0 }) {
            items.append(Item(currencyKey: currency.key, currencyName: currency.value, isSelected: false))
        }
        return items
    }
}
