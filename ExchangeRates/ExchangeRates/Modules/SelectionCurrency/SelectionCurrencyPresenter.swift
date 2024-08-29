import UIKit

protocol SelectionCurrencyPresenterProtocol {
    var title: String { get }
    var completionCurrency: ((CurrencyId) -> Void)? { get }
    var completionList: (([CurrencyId]) -> Void)? { get }
    func viewDidLoad()
    func tapCell(index: Int)
}

final class SelectionCurrencyPresenter: SelectionCurrencyPresenterProtocol {
    weak var view: SelectionCurrencyViewProtocol?

    var title: String { "Add currency" }

    private let symbolsModel: SymbolsModel
    private var model: SelectionCurrencyView.Model = .init(items: [])

    private var soldCurrency: CurrencyId?
    private var purchasedCurrenciesList: [CurrencyId]?

    private let isSingleCellSelectionMode: Bool

//    private var selected = Set<CurrencyId>() // FIXME: ?

//    var onChanged: ((Set<CurrencyId>) -> Void)? // FIXME: ?

    var completionCurrency: ((CurrencyId) -> Void)?
    var completionList: (([CurrencyId]) -> Void)?

    init(
        symbolsModel: SymbolsModel,
        soldCurrency: CurrencyId? = nil,
        purchasedCurrenciesList: [CurrencyId]? = nil,
        isSingleCellSelectionMode: Bool
    ) {
        self.symbolsModel = symbolsModel
        self.soldCurrency = soldCurrency
        self.purchasedCurrenciesList = purchasedCurrenciesList
        self.isSingleCellSelectionMode = isSingleCellSelectionMode
    }

    func viewDidLoad() {
        let resultingModel: SelectionCurrencyView.Model = .init(items: createModelItem(symbolsModel: symbolsModel))
        model = indicateSelectedCurrency(resultingModel: resultingModel)
        view?.update(model: model)
    }

    func tapCell(index: Int) {
        //        guard var model = model else { return }
        if isSingleCellSelectionMode {
            guard let previousIndex = model.items.firstIndex(where: { $0.isSelected == true }) else { return }
            model.items[previousIndex].isSelected = false
            model.items[index].isSelected = true
            let key = model.items[index].currencyKey
            soldCurrency = key
            completionCurrency?(key)
        } else {
            let isSelected = model.items[index].isSelected
            model.items[index].isSelected = !isSelected
            let list = model.items.filter { $0.isSelected == true }.reduce([CurrencyId]()) { result, next in
                result + [next.currencyKey]
            }
            purchasedCurrenciesList = list
            completionList?(list)
        }
        view?.update(model: model)
    }
}

private extension SelectionCurrencyPresenter {
    func indicateSelectedCurrency(resultingModel: SelectionCurrencyView.Model) -> SelectionCurrencyView.Model {
        var model = resultingModel
        if isSingleCellSelectionMode {
            let index = model.items.firstIndex(where: { $0.currencyKey == soldCurrency })
            if let index = index {
                model.items[index].isSelected = true
            }
        } else {
            if let currencyList = purchasedCurrenciesList {
                for element in currencyList {
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
