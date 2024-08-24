import UIKit

protocol ConverterCurrencyViewProtocol: AnyObject {
    //    func setupNavBar() -> UIBarButtonItem
    //    func updateButtonNavBar(button: UIBarButtonItem)
    func updateSoldCurrency(model: ConverterCurrencyView.SoldCurrencyModel)
    func updateListPurchasedCurrencies(model: ConverterCurrencyView.ListPurchasedCurrenciesModel)
    //    func showError()
    //    func showEmpty()
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
        customView.startLoader()
    }

    func stopLoader() {
        customView.stopLoader()
    }

    func updateSoldCurrency(model: ConverterCurrencyView.SoldCurrencyModel) {
        customView.updateSoldCurrency(model: model)
    }

    func updateListPurchasedCurrencies(model: ConverterCurrencyView.ListPurchasedCurrenciesModel) {
        customView.updateListPurchasedCurrencies(model: model)
    }
}
