import UIKit

protocol ConverterCurrencyViewProtocol: AnyObject {
    //    func setupNavBar() -> UIBarButtonItem
    //    func updateButtonNavBar(button: UIBarButtonItem)
    func updateConvertibleCurrency(model: ConverterCurrencyView.ConvertibleCurrencyModel)
    func updateListExchangeCurrencies(model: ConverterCurrencyView.ConvertibleCurrencyListModel)
    //    func showError()
    //    func showEmpty()
    func startLoader()
    func stopLoader()
}

class ConverterCurrencyViewController: UIViewController {
    let networkClient = NetworkClient()
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
        presenter.viewDidLoad()
        view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
    }

    override func viewDidLayoutSubviews() {
        navigationController?.hidesBarsOnSwipe = false
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

    func updateConvertibleCurrency(model: ConverterCurrencyView.ConvertibleCurrencyModel) {
        customView.updateConvertibleCurrency(model: model)
    }

    func updateListExchangeCurrencies(model: ConverterCurrencyView.ConvertibleCurrencyListModel) {
        customView.updateListExchangeCurrencies(model: model)
    }
}
