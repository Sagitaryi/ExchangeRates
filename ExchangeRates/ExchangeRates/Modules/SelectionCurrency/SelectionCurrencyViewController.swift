import UIKit

protocol SelectionCurrencyViewProtocol: AnyObject {
    func update(model: SelectionCurrencyView.Model)
}

final class SelectionCurrencyViewController: UIViewController {
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
    }

    deinit {
        print(">>> ModuleSelectionCurrency is deinit")
    }
}

extension SelectionCurrencyViewController: SelectionCurrencyViewProtocol {
    func update(model: SelectionCurrencyView.Model) {
        customView.update(model: model)
    }
}
