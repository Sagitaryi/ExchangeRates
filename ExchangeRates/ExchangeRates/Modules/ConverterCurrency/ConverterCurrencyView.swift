import UIKit

final class ConverterCurrencyView: UIView {
    // Модель через которую передают все изменения во View

    struct SoldCurrencyModel {
        var flag: UIImage?
        let currencyKey: String
        let currencyName: String
        var amount: String = "0"
    }

    struct Model {
        let items: [ConverterCurrencyTableViewCell.Model]
    }

    private var soldCurrency: SoldCurrencyModel?

    private let tableManager = ConverterCurrencyViewTableManager()

    private lazy var editBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editTapped))
        return barButtonItem
    }()

    private lazy var loaderView: UIView = {
        let view = LoaderView()

//        let view = UIView()
//        view.backgroundColor = .systemGray
        return view
    }()

//    private lazy var loaderImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.contentMode = .scaleAspectFill
//        imageView.image = UIImage(named: "obmen-valut")
//        return imageView
//    }()
//
//    private lazy var headerLoaderLabel: UILabel = {
//        let label = UILabel()
//        label.font = UIFont(name: "Futura-Medium", size: 45)
//        label.textColor = .white
//        label.text = "CURRENCY"
//        return label
//    }()
//
//    private lazy var activityIndicator: UIActivityIndicatorView = {
//        let spinner = UIActivityIndicatorView(style: .large)
//        spinner.startAnimating()
//        return spinner
//    }()

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
        let table = UITableView()

        table.register(
            ConverterCurrencyTableViewCell.self,
            forCellReuseIdentifier: ConverterCurrencyTableViewCell.id
        )
        table.separatorInset = .zero
        table.tableFooterView = UIView()
        table.backgroundColor = .systemBackground
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false

        tableManager.set(tableView: table)
        return table
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

    func updateTablePurchasedCurrencies(model: Model, lastDateReceivedData: String) {
        dateReceivedDataLabel.text = lastDateReceivedData // "Last update: \(date)" // FIXME: проверить формат string
        tableManager.bind(items: model.items)
    }

    func updateTableView(table: UITableView) {
        tableWithCurrenciesView = table
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
        addSubview(loaderView)
        setupConstraintsLoader()
    }

    func stopLoader() {
        loaderView.isHidden = true
    }
}

private extension ConverterCurrencyView {
    func commonInit() {
        backgroundColor = .white
        setupSubviews()
        setupConstraints()
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

        NSLayoutConstraint.activate([
            loaderView.topAnchor.constraint(equalTo: topAnchor),
            loaderView.bottomAnchor.constraint(equalTo: bottomAnchor),
            loaderView.leadingAnchor.constraint(equalTo: leadingAnchor),
            loaderView.trailingAnchor.constraint(equalTo: trailingAnchor),
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

    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        let heightRow: CGFloat = 48
        return heightRow
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
}
