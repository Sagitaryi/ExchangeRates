//
//  ModuleSelectionCurrencyRouter.swift
//  ExchangeRates
//
//  Created by Алексей Чумаков on 07.06.2024.
//

import UIKit

// Роутер, который открывает все переходы с модуля Alpha
protocol ModuleSelectionCurrencyRouterProtocol: AnyObject {
    // Устанавливаем основной UIViewController
    func setRootViewController(root: UIViewController)

    // Модуль Alpha показывает модуль Beta и передает в него параметры.
    func openModuleSelectionCurrency(with param: String)
}

final class ModuleSelectionCurrencyRouter: ModuleSelectionCurrencyRouterProtocol {
//    private let factory: ModuleSelectionCurrencyFactory
    private let factory: ModuleSelectionCurrencyFactory

    private weak var root: UIViewController?

    init(factory: ModuleSelectionCurrencyFactory) {
        self.factory = factory
    }

    func setRootViewController(root: UIViewController) {
        self.root = root
    }

//     Модуль Alpha показывает модуль Beta и передает в него параметры.
    func openModuleSelectionCurrency(with param: String) {
        let context = ModuleSelectionCurrencyFactory.Context(
            someParam: param,
            someValue: 100
        )

        let viewController = factory.make()
        root?.navigationController?.pushViewController(viewController, animated: true)
    }
}
