import UIKit

protocol ModuleConverterCurrencyViewProtocol: AnyObject {
    //    func setupNavBar() -> UIBarButtonItem
    //    func updateButtonNavBar(button: UIBarButtonItem)
    //    func update(model: ModuleAlphaView.Model)
    //    func showError()
    //    func showEmpty()
    //    func startLoader()
    //    func stopLoader()
}

class ModuleConverterCurrencyViewController: UIViewController {
    let networkClient = NetworkClient()
    private let presenter: ModuleConverterCurrencyPresenterProtocol
    private lazy var customView = ModuleConverterCurrencyView(presenter: presenter)

    init(presenter: ModuleConverterCurrencyPresenterProtocol) {
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

    override func viewDidLayoutSubviews() {
        navigationController?.hidesBarsOnSwipe = false
    }

    func setupNavBar() {
        title = presenter.title
        navigationController?.hidesBarsOnSwipe = false
        navigationItem.rightBarButtonItem = customView.addButtonEditNavBar()
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
}

extension ModuleConverterCurrencyViewController: ModuleConverterCurrencyViewProtocol {}
