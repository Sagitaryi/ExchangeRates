import UIKit

protocol ConverterCurrencyViewProtocol: AnyObject {
    func updateSoldCurrency(model: ConverterCurrencyView.SoldCurrencyModel)
    func updateTablePurchasedCurrencies(model: ConverterCurrencyView.Model, lastDateReceivedData: String)
    func updateTableView(table: UITableView)
    func startLoader()
    func stopLoader()
}

final class ConverterCurrencyViewController: UIViewController {
    private let presenter: ConverterCurrencyPresenterProtocol
    private lazy var customView = ConverterCurrencyView(presenter: presenter)

    init(presenter: ConverterCurrencyPresenterProtocol) {
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
        setupNavBar()
        presenter.viewDidLoad()
    }

    func setupNavBar() {
        title = presenter.title
        navigationController?.hidesBarsOnSwipe = false
        navigationItem.rightBarButtonItem = customView.addButtonEditNavBar()
    }
}

extension ConverterCurrencyViewController: ConverterCurrencyViewProtocol {
    func startLoader() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        customView.startLoader()
    }

    func stopLoader() {
        navigationController?.setNavigationBarHidden(false, animated: false)
        customView.stopLoader()
    }

    func updateSoldCurrency(model: ConverterCurrencyView.SoldCurrencyModel) {
        customView.updateSoldCurrency(model: model)
    }

    func updateTablePurchasedCurrencies(model: ConverterCurrencyView.Model, lastDateReceivedData: String) {
        customView.updateTablePurchasedCurrencies(model: model, lastDateReceivedData: lastDateReceivedData)
    }

    func updateTableView(table: UITableView) {
        customView.updateTableView(table: table)
    }
}
