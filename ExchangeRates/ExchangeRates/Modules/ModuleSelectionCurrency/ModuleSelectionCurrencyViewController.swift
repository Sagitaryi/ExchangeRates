//
//  ModuleSelectionCurrencyViewController.swift
//  ExchangeRates
//
//  Created by Алексей Чумаков on 07.06.2024.
//
import UIKit

protocol ModuleSelectionCurrencyViewProtocol: AnyObject {
//    func setupNavBar() -> UIBarButtonItem
//    func updateButtonNavBar(button: UIBarButtonItem)
//    func update(model: ModuleAlphaView.Model)
//    func showError()
//    func showEmpty()
//    func startLoader()
//    func stopLoader()
}

class ModuleSelectionCurrencyViewController: UIViewController {
    let networkClient = NetworkClient()
    private let presenter: ModuleSelectionCurrencyPresenterProtocol
    private lazy var customView = ModuleSelectionCurrencyView(presenter: presenter)

    init(presenter: ModuleSelectionCurrencyPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .systemBlue
        setupNavBar()
    }

    func setupNavBar() {
        title = presenter.title
        navigationController?.hidesBarsOnSwipe = true
//        navigationItem.rightBarButtonItem = customView.addButtonEditNavBar()
    }

    @IBAction func getAllCurrenciesButtonPressed(_: UIButton) {
        let symbolsService = SymbolsService(networkClient: networkClient)
        symbolsService.fetchSymbols { result in
            switch result {
            case let .success(data):
                print(data)
            case let .failure(error):
                print(error)
            }
        }
        print("end")
    }

    @IBAction func getExchangeRateButtonPressed(_: UIButton) {
        let ratesService = RatesService(networkClient: networkClient)
        ratesService.fetchRates(base: "EUR", symbols: ["USD", "RUB", "PHP", "PAB"]) { result in
            switch result {
            case let .success(model):
                print(model)
            case let .failure(error):
                print(error)
            }
        }
    }

    deinit {
        print(">>> ModuleBetaViewController is deinit")
    }
}

extension ModuleSelectionCurrencyViewController: ModuleSelectionCurrencyViewProtocol {}