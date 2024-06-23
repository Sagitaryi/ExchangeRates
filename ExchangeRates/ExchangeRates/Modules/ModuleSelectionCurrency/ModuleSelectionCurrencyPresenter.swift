//
//  ModuleSelectionCurrencyPresenter.swift
//  ExchangeRates
//
//  Created by Алексей Чумаков on 07.06.2024.
//

import UIKit

protocol ModuleSelectionCurrencyPresenterProtocol {
    var title: String { get }
    func viewDidLoad()
    func showNextVCTapButton()
}

final class ModuleSelectionCurrencyPresenter: ModuleSelectionCurrencyPresenterProtocol {
    weak var view: ModuleSelectionCurrencyViewProtocol?

    private let networkClient: NetworkClientProtocol
    private let router: ModuleSelectionCurrencyRouterProtocol

    var title: String { "Add currency" }

    init(
        networkClient: NetworkClientProtocol,
        router: ModuleSelectionCurrencyRouterProtocol
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
                print(data)
                let model: ModuleSelectionCurrencyView.Model = .init(items: createModelItem(symbolsModel: data))
                view?.update(model: model)
            case let .failure(error):
                print(error)
            }
        }
    }

    private func createModelItem(symbolsModel: SymbolsModel) -> [Item] {
        var items: [Item] = []
        for currency in symbolsModel.symbols {
            items.append(Item(key: currency.key, value: currency.value, isSelected: false))
        }
        return items
    }

    func showNextVCTapButton() {
        // открыть модуль Beta и передать туда параметры
//        router.openModuleSelectionCurrency(with: "sdfs")
    }
}
