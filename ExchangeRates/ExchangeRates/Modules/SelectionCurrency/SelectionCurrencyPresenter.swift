import UIKit

protocol SelectionCurrencyPresenterProtocol {
    var title: String { get }
    var onChanged: ((Set<CurrencyId>) -> Void)? { get }
    func viewDidLoad()
    func tapCell(index: Int)
}

final class SelectionCurrencyPresenter: SelectionCurrencyPresenterProtocol {
    weak var view: SelectionCurrencyViewProtocol?
    var onChanged: ((Set<CurrencyId>) -> Void)?

    var title: String {
        let header: String
        if isSingleCellSelectionMode {
            header = "Add currency"
        } else {
            header = "Select currencies"
        }
        return header
    }

    private let symbolsModel: SymbolsModel
    private var model: SelectionCurrencyView.Model = .init(items: [])
    private let isSingleCellSelectionMode: Bool
    private var selected: Set<CurrencyId>

    init(
        selected: Set<CurrencyId>,
        symbolsModel: SymbolsModel,
        onChanged: ((Set<CurrencyId>) -> Void)?,
        isSingleCellSelectionMode: Bool
    ) {
        self.selected = selected
        self.symbolsModel = symbolsModel
        self.onChanged = onChanged
        self.isSingleCellSelectionMode = isSingleCellSelectionMode
    }

    func viewDidLoad() {
        let model = createNewModel()
        self.model = model
        view?.update(model: model)
    }

    func tapCell(index: Int) {
        let pressedElement = model.items[index].currencyKey
        if isSingleCellSelectionMode {
            selected.removeAll()
            selected.insert(pressedElement)
            model = createNewModel()
            view?.update(model: model)
        } else {
            if selected.contains(pressedElement) {
                selected.remove(pressedElement)
            } else {
                selected.insert(pressedElement)
            }
            model = createNewModel()
            view?.update(model: model)
        }
        onChanged?(selected)
    }
}

private extension SelectionCurrencyPresenter {
    func createNewModel() -> SelectionCurrencyView.Model {
        var model: SelectionCurrencyView.Model = .init(items: [])
        for item in Array(symbolsModel.symbols).sorted(by: { $0.0 < $1.0 }) {
            let key = item.key
            let name = item.value
            var isSelected = selected.contains(item.key)
            model.items.append(.init(currencyKey: key, currencyName: name, isSelected: isSelected))
        }
        return model
    }
}
