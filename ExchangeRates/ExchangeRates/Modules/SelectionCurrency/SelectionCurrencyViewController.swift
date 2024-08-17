import UIKit

protocol SelectionCurrencyViewProtocol: AnyObject {
//    func setupNavBar() -> UIBarButtonItem
//    func updateButtonNavBar(button: UIBarButtonItem)
    func update(model: SelectionCurrencyView.Model)
//    func updateStateSingleCellSelectionMode(state: Bool)
//    func showError()
//    func showEmpty()
//    func startLoader()
    func stopLoader()
}

class SelectionCurrencyViewController: UIViewController {
    let networkClient = NetworkClient()
    private let presenter: SelectionCurrencyPresenterProtocol
    private lazy var customView = SelectionCurrencyView(presenter: presenter)

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
        setupNavBar()
        presenter.viewDidLoad()
    }

    func setupNavBar() {
        title = presenter.title
        navigationController?.hidesBarsOnSwipe = true
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
