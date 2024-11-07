import UIKit

protocol SelectionCurrencyPresenterProtocol {
    var title: String { get }
    var onChanged: ((Set<CurrencyId>) -> Void)? { get }
    func viewDidLoad()
    func tapRow(index: Int)
}

final class SelectionCurrencyPresenter: SelectionCurrencyPresenterProtocol {
    weak var view: SelectionCurrencyViewProtocol?
    var onChanged: ((Set<CurrencyId>) -> Void)?

    var title: String {
        let header: String
        header = isSingleCellSelectionMode ? "Add currency" : "Select currencies"
        return header
    }

    private let symbolsModel: SymbolsModel
    private var model = [SelectionCurrencyTableViewCell.Model]()
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
        updateUI()
    }

    func tapRow(index: Int) {
        let pressedElement = model[index].currencyKey
        print(pressedElement)

        if isSingleCellSelectionMode {
            selected.removeAll()
            selected.insert(pressedElement)
            updateUI()
        } else {
            if selected.contains(pressedElement) {
                selected.remove(pressedElement)
            } else {
                selected.insert(pressedElement)
            }
        }
        updateUI()
        onChanged?(selected)
    }
}

private extension SelectionCurrencyPresenter {
    func updateUI() {
        guard symbolsModel.symbols.count > 0 else {
//            view?.showEmpty() // FIXME: для использования в будующем
            return
        }

        var model = [SelectionCurrencyTableViewCell.Model]()
        for item in Array(symbolsModel.symbols).sorted(by: { $0.0 < $1.0 }) {
            let key = item.key
            let name = item.value
            let isSelected = selected.contains(item.key)
            model.append(
                .init(
                    currencyFullName: "\(key) - \(name)",
                    currencyKey: key,
                    currencyName: name,
                    isSelected: isSelected
                )
            )
        }
        self.model = model
        let viewModel = SelectionCurrencyView.Model(items: model)
        view?.update(model: viewModel)
    }
}
