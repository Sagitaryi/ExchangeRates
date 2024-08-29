import UIKit

final class ConverterCurrencyView: UIView {
    // Модель через которую передают все изменения во View

    struct SoldCurrencyModel {
        var flag: UIImage?
        var currencyKey: String
        var currencyName: String
        var amount: String = "0"
    }

    struct ListPurchasedCurrenciesModel {
        var items: [Item]
        var lastDateReceivedData: Date?

        struct Item {
            var flag: UIImage?
            var currencyKey: String
            var currencyName: String
            var amount: String = "0"
            var rate: String = "0"
        }
    }

    private var soldCurrency: SoldCurrencyModel?
    private var listPurchasedCurrencies: ListPurchasedCurrenciesModel?

    private lazy var editBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editTapped))
        return barButtonItem
    }()

    private lazy var loaderView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray
        return view
    }()

    private lazy var loaderImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "objmen-valjut")
        return imageView
    }()

    private lazy var headerLoaderLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Futura-Medium", size: 45)
        label.textColor = .white
        label.text = "CURRENCY"
        return label
    }()

    private lazy var activityIndicator: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.startAnimating()
        return spinner
    }()

    private lazy var topBlockContentView: UIView = {
        let view = UIView()
        return view
    }()

    private lazy var headerSoldCurrencyLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 17)
        label.textColor = .gray
        label.text = "From:"
        return label
    }()

    private lazy var blockSoldCurrencyView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.backgroundColor = .systemBlue
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(soldCurrencyTapped))
        view.addGestureRecognizer(recognizer)
        return view
    }()

    private lazy var countryFlagImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private lazy var soldCurrencyLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.textColor = .white
        return label
    }()

    private lazy var descriptionSoldCurrencyLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.textColor = .white
        return label
    }()

    private lazy var betTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 5
        textField.layer.borderColor = .init(red: 242, green: 242, blue: 247, alpha: 0.4)
        textField.placeholder = "Enter the amount..."
        textField.delegate = self
        return textField
    }()

    private lazy var headerPurchasedCurrenciesLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 17)
        label.textColor = .gray
        label.text = "To:"
        return label
    }()

    private lazy var middleBlockContentView: UIView = {
        let view = UIView()
        return view
    }()

    private lazy var tableWithCurrenciesView: UITableView = {
        let tableview = UITableView()
        tableview.register(ConverterCurrencyTableViewCell.self, forCellReuseIdentifier: "Cell")
        tableview.delegate = self
        tableview.dataSource = self
        return tableview
    }()

    private lazy var footterBlockDateReceivedDataView: UIView = {
        let view = UIView()
        return view
    }()

    private lazy var dateReceivedDataLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.textColor = .gray
        label.textAlignment = .right
        return label
    }()

    private let presenter: ConverterCurrencyPresenterProtocol

    init(presenter: ConverterCurrencyPresenterProtocol) {
        self.presenter = presenter
        super.init(frame: .zero)
        commonInit()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateSoldCurrency(model: SoldCurrencyModel) {
        soldCurrency = model
        countryFlagImageView.image = model.flag
        soldCurrencyLabel.text = model.currencyKey
        descriptionSoldCurrencyLabel.text = model.currencyName
        betTextField.text = model.amount
    }

    func updateListPurchasedCurrencies(model: ListPurchasedCurrenciesModel) {
        listPurchasedCurrencies = model
        if let date = listPurchasedCurrencies?.lastDateReceivedData {
            dateReceivedDataLabel.text = "Last update: \(date)"
        }
        tableWithCurrenciesView.reloadData()
    }

    func addButtonEditNavBar() -> UIBarButtonItem {
        return editBarButtonItem
    }

    func showError() {
        // Показываем View ошибки
    }

    func showEmpty() {
        // Показываем какой-то View для Empty state
    }

    func startLoader() {
        // Показываем скелетон или лоадер
        setupSubviewLoader()
        setupConstraintsLoader()
    }

    func stopLoader() {
        // Скрываем все
        loaderView.removeFromSuperview()
    }
}

private extension ConverterCurrencyView {
    func commonInit() {
        backgroundColor = .white
        setupSubviews()
        setupConstraints()
    }

    func setupSubviewLoader() {
        addSubview(loaderView)
        loaderView.addSubview(loaderImageView)
        loaderView.addSubview(headerLoaderLabel)
        loaderView.addSubview(activityIndicator)
    }

    func setupSubviews() {
        addSubview(topBlockContentView)
        topBlockContentView.addSubview(headerSoldCurrencyLabel)
        topBlockContentView.addSubview(blockSoldCurrencyView)
        topBlockContentView.addSubview(headerPurchasedCurrenciesLabel)

        blockSoldCurrencyView.addSubview(countryFlagImageView)
        blockSoldCurrencyView.addSubview(soldCurrencyLabel)
        blockSoldCurrencyView.addSubview(descriptionSoldCurrencyLabel)
        blockSoldCurrencyView.addSubview(betTextField)

        addSubview(middleBlockContentView)
        middleBlockContentView.addSubview(tableWithCurrenciesView)

        addSubview(footterBlockDateReceivedDataView)
        footterBlockDateReceivedDataView.addSubview(dateReceivedDataLabel)
    }

    func setupConstraintsLoader() {
        loaderView.translatesAutoresizingMaskIntoConstraints = false
        loaderImageView.translatesAutoresizingMaskIntoConstraints = false
        headerLoaderLabel.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            loaderView.topAnchor.constraint(equalTo: topAnchor),
            loaderView.bottomAnchor.constraint(equalTo: bottomAnchor),
            loaderView.leadingAnchor.constraint(equalTo: leadingAnchor),
            loaderView.trailingAnchor.constraint(equalTo: trailingAnchor),

            loaderImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            loaderImageView.bottomAnchor.constraint(equalTo: headerLoaderLabel.topAnchor, constant: -30),
            loaderImageView.widthAnchor.constraint(equalToConstant: 60),
            loaderImageView.heightAnchor.constraint(equalToConstant: 60),

            headerLoaderLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            headerLoaderLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.topAnchor.constraint(equalTo: headerLoaderLabel.bottomAnchor, constant: 30),
            activityIndicator.heightAnchor.constraint(equalToConstant: 80),
            activityIndicator.widthAnchor.constraint(equalToConstant: 80),
        ])
    }

    func setupConstraints() {
        topBlockContentView.translatesAutoresizingMaskIntoConstraints = false
        headerSoldCurrencyLabel.translatesAutoresizingMaskIntoConstraints = false
        blockSoldCurrencyView.translatesAutoresizingMaskIntoConstraints = false
        countryFlagImageView.translatesAutoresizingMaskIntoConstraints = false
        soldCurrencyLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionSoldCurrencyLabel.translatesAutoresizingMaskIntoConstraints = false
        betTextField.translatesAutoresizingMaskIntoConstraints = false
        headerPurchasedCurrenciesLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            topBlockContentView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            topBlockContentView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            topBlockContentView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            topBlockContentView.heightAnchor.constraint(equalToConstant: 118),

            headerSoldCurrencyLabel.topAnchor.constraint(equalTo: topBlockContentView.topAnchor, constant: 8),
            headerSoldCurrencyLabel.leadingAnchor.constraint(equalTo: topBlockContentView.leadingAnchor,
                                                             constant: 16),
            headerSoldCurrencyLabel.trailingAnchor.constraint(equalTo: topBlockContentView.trailingAnchor,
                                                              constant: 16),

            blockSoldCurrencyView.topAnchor.constraint(equalTo: headerSoldCurrencyLabel.bottomAnchor,
                                                       constant: 9),
            blockSoldCurrencyView.leadingAnchor.constraint(equalTo: topBlockContentView.leadingAnchor,
                                                           constant: 16),
            blockSoldCurrencyView.trailingAnchor.constraint(equalTo: topBlockContentView.trailingAnchor,
                                                            constant: -16),
            blockSoldCurrencyView.bottomAnchor.constraint(equalTo: headerPurchasedCurrenciesLabel.topAnchor,
                                                          constant: -9),

            countryFlagImageView.leadingAnchor.constraint(equalTo: blockSoldCurrencyView.leadingAnchor,
                                                          constant: 8),
            countryFlagImageView.heightAnchor.constraint(equalToConstant: 12),
            countryFlagImageView.widthAnchor.constraint(equalToConstant: 16),
            countryFlagImageView.topAnchor.constraint(equalTo: blockSoldCurrencyView.topAnchor, constant: 15),
            countryFlagImageView.bottomAnchor.constraint(equalTo: blockSoldCurrencyView.bottomAnchor,
                                                         constant: -15),

            betTextField.topAnchor.constraint(equalTo: blockSoldCurrencyView.topAnchor, constant: 2),
            betTextField.trailingAnchor.constraint(equalTo: blockSoldCurrencyView.trailingAnchor, constant: -3),
            betTextField.bottomAnchor.constraint(equalTo: blockSoldCurrencyView.bottomAnchor, constant: -2),
            betTextField.widthAnchor.constraint(equalToConstant: 124),

            soldCurrencyLabel.topAnchor.constraint(equalTo: blockSoldCurrencyView.topAnchor,
                                                   constant: 0),
            soldCurrencyLabel.leadingAnchor.constraint(equalTo: countryFlagImageView.trailingAnchor,
                                                       constant: 15),
            soldCurrencyLabel.trailingAnchor.constraint(equalTo: betTextField.leadingAnchor, constant: -15),

            descriptionSoldCurrencyLabel.topAnchor.constraint(equalTo: soldCurrencyLabel.bottomAnchor,
                                                              constant: 0),
            descriptionSoldCurrencyLabel.leadingAnchor.constraint(equalTo: soldCurrencyLabel.leadingAnchor),
            descriptionSoldCurrencyLabel.trailingAnchor.constraint(equalTo:
                soldCurrencyLabel.trailingAnchor),

            headerPurchasedCurrenciesLabel.topAnchor.constraint(equalTo: topBlockContentView.topAnchor, constant: 88),
            headerPurchasedCurrenciesLabel.leadingAnchor.constraint(equalTo: topBlockContentView.leadingAnchor,
                                                                    constant: 16),
            headerPurchasedCurrenciesLabel.trailingAnchor.constraint(equalTo: topBlockContentView.trailingAnchor,
                                                                     constant: 16),

        ])

        middleBlockContentView.translatesAutoresizingMaskIntoConstraints = false
        tableWithCurrenciesView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            middleBlockContentView.topAnchor.constraint(equalTo: topBlockContentView.bottomAnchor),
            middleBlockContentView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            middleBlockContentView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            middleBlockContentView.bottomAnchor.constraint(equalTo: footterBlockDateReceivedDataView.topAnchor, constant: -16),

            tableWithCurrenciesView.topAnchor.constraint(equalTo: middleBlockContentView.topAnchor, constant: 4),
            tableWithCurrenciesView.leadingAnchor.constraint(equalTo: middleBlockContentView.leadingAnchor, constant: 0),
            tableWithCurrenciesView.trailingAnchor.constraint(equalTo: middleBlockContentView.trailingAnchor,
                                                              constant: -16),
            tableWithCurrenciesView.bottomAnchor.constraint(equalTo: middleBlockContentView.bottomAnchor),
        ])

        footterBlockDateReceivedDataView.translatesAutoresizingMaskIntoConstraints = false
        dateReceivedDataLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            footterBlockDateReceivedDataView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            footterBlockDateReceivedDataView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            footterBlockDateReceivedDataView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            footterBlockDateReceivedDataView.heightAnchor.constraint(equalToConstant: 70),

            dateReceivedDataLabel.centerYAnchor.constraint(equalTo: footterBlockDateReceivedDataView.centerYAnchor),
            dateReceivedDataLabel.leadingAnchor.constraint(equalTo: footterBlockDateReceivedDataView.leadingAnchor, constant: 22),
            dateReceivedDataLabel.trailingAnchor.constraint(equalTo: footterBlockDateReceivedDataView.trailingAnchor, constant: -22),
        ])
    }

    @objc
    func soldCurrencyTapped() {
        presenter.soldCurrencyTapped()
    }

    @objc
    func editTapped() {
        presenter.editButtonTapped()
    }
}

extension ConverterCurrencyView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let value = textField.text else { return false }
        presenter.updateAmount(text: value)
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
}

extension ConverterCurrencyView: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        guard let list = listPurchasedCurrencies else { return 0 }
        return list.items.count
    }

    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        let heightRow: CGFloat = 48
        return heightRow
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableWithCurrenciesView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? ConverterCurrencyTableViewCell else { fatalError() }
        guard let model = listPurchasedCurrencies else { return cell }
        if let baseCurrency = soldCurrency?.currencyKey {
            cell.configure(baseCurrency: baseCurrency, model: model, index: indexPath.row)
        }
        return cell
    }
}

extension ConverterCurrencyView: UITableViewDelegate {} // TODO: можно ли перенести к View
