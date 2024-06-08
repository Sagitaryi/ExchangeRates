//
//  ModuleSelectionCurrencyPresenter.swift
//  ExchangeRates
//
//  Created by Алексей Чумаков on 07.06.2024.
//

import UIKit

protocol ModuleSelectionCurrencyPresenterProtocol {
    var title: String { get }
//    var analiticScreenName: String { get }
//
//    func viewDidLoad()
    func showNextVCTapButton()
}

final class ModuleSelectionCurrencyPresenter: ModuleSelectionCurrencyPresenterProtocol {
    weak var view: ModuleSelectionCurrencyViewProtocol?

    private let networkClient: NetworkClientProtocol
    private let router: ModuleSelectionCurrencyRouterProtocol

    var title: String { "Add currency" }

//    var analiticScreenName: String { "module_a_screen_name" }

    init(
        networkClient: NetworkClientProtocol,
        router: ModuleSelectionCurrencyRouterProtocol
    ) {
        self.networkClient = networkClient
        self.router = router
    }

//    func viewDidLoad() {
//        view?.stopLoader()
//        service.requestData { [weak self] (result: Result<String, Error>) in
//            guard let self else { return }
//            view?.stopLoader()
//
//            switch result {
//            case let .success(model):
//                let model = ModuleAlphaView.Model(
//                    text: model,
//                    buttonText: "Go Go Go"
//                )
//                view?.update(model: model)
//                break
//            case .failure:
//                view?.showError()
//            }
//        }
//    }
//
    func showNextVCTapButton() {
        // открыть модуль Beta и передать туда параметры
        router.openModuleSelectionCurrency(with: "sdfs")
    }
}
