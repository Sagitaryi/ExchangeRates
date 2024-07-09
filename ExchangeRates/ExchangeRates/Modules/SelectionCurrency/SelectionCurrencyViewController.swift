//
//  ModuleSelectionCurrencyViewController.swift
//  ExchangeRates
//
//  Created by Алексей Чумаков on 07.06.2024.
//
import UIKit

protocol SelectionCurrencyViewProtocol: AnyObject {
//    func setupNavBar() -> UIBarButtonItem
//    func updateButtonNavBar(button: UIBarButtonItem)
    func update(model: SelectionCurrencyView.Model)
//    func showError()
//    func showEmpty()
//    func startLoader()
    func stopLoader()
}

class SelectionCurrencyViewController: UIViewController {
    let networkClient = NetworkClient()
    private let presenter: SelectionCurrencyPresenterProtocol
    private lazy var customView = SelectionCurrencyView(presenter: presenter)
//    private let table: UITableView = .init()

    init(presenter: SelectionCurrencyPresenterProtocol) {
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
        presenter.viewDidLoad()
//        table
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

extension SelectionCurrencyViewController: SelectionCurrencyViewProtocol {
    func update(model: SelectionCurrencyView.Model) {
        customView.update(model: model)
    }

    func stopLoader() {
        customView.stopLoader()
    }
}

// extension SelectionCurrencyViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 2
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
//
//
// }
