import UIKit

final class ConverterCurrencyView: UIView {
    // Модель через которую передают все изменения во View

    struct ConvertibleCurrencyModel {
        var flag: UIImage?
        var currencyKey: String
        var currencyName: String
        var amount: Double = 0
    }

    struct ConvertibleCurrencyListModel {
        var items: [Item]
        var lastDateReceivedData: Date?
        struct Item {
            var flag: UIImage?
            var currencyKey: String
            var currencyName: String
            var amount: Double = 0
            var rate: Double = 0
        }
    }

    private var convertibleCurrency: ConvertibleCurrencyModel?
    private var currencyList: ConvertibleCurrencyListModel?

    private lazy var editBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editTapped))
        return barButtonItem
    }()

    private lazy var topBlockContentView: UIView = {
        let view = UIView()
        return view
    }()

    private lazy var headerConvertibleCurrencyLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 17)
        label.textColor = .gray
        label.text = "From:"
        return label
    }()

    private lazy var blockConvertibleCurrencyView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.backgroundColor = .systemBlue
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(currencyTapped))
        view.addGestureRecognizer(recognizer)
        return view
    }()

    private lazy var countryFlagImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private lazy var convertibleCurrencyLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.textColor = .white
        return label
    }()

    private lazy var descriptionConvertibleCurrencyLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.textColor = .white
        return label
    }()

    private lazy var betTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .bezel
        textField.keyboardType = .numberPad
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 5
        textField.layer.borderColor = .init(red: 242, green: 242, blue: 247, alpha: 0.4)
        textField.delegate = self

        return textField
    }()

    private lazy var headerExchangeCurrenciesLabel: UILabel = {
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

    private lazy var tableWithCurrencyView: UITableView = {
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

    func updateConvertibleCurrency(model: ConvertibleCurrencyModel) {
        convertibleCurrency = model
        countryFlagImageView.image = model.flag
        convertibleCurrencyLabel.text = model.currencyKey
        descriptionConvertibleCurrencyLabel.text = model.currencyName
    }

    func updateListExchangeCurrencies(model: ConvertibleCurrencyListModel) {
        currencyList = model
        if let date = currencyList?.lastDateReceivedData {
            dateReceivedDataLabel.text = "Last update: \(date)"
        }
        tableWithCurrencyView.reloadData()
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
    }

    func stopLoader() {
        // Скрываем все
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
        topBlockContentView.addSubview(headerConvertibleCurrencyLabel)
        topBlockContentView.addSubview(blockConvertibleCurrencyView)
        topBlockContentView.addSubview(headerExchangeCurrenciesLabel)

        blockConvertibleCurrencyView.addSubview(countryFlagImageView)
        blockConvertibleCurrencyView.addSubview(convertibleCurrencyLabel)
        blockConvertibleCurrencyView.addSubview(descriptionConvertibleCurrencyLabel)
        blockConvertibleCurrencyView.addSubview(betTextField)

        addSubview(middleBlockContentView)
        middleBlockContentView.addSubview(tableWithCurrencyView)

        addSubview(footterBlockDateReceivedDataView)
        footterBlockDateReceivedDataView.addSubview(dateReceivedDataLabel)
    }

    func setupConstraints() {
        topBlockContentView.translatesAutoresizingMaskIntoConstraints = false
        headerConvertibleCurrencyLabel.translatesAutoresizingMaskIntoConstraints = false
        blockConvertibleCurrencyView.translatesAutoresizingMaskIntoConstraints = false
        countryFlagImageView.translatesAutoresizingMaskIntoConstraints = false
        convertibleCurrencyLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionConvertibleCurrencyLabel.translatesAutoresizingMaskIntoConstraints = false
        betTextField.translatesAutoresizingMaskIntoConstraints = false
        headerExchangeCurrenciesLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            topBlockContentView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            topBlockContentView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            topBlockContentView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            topBlockContentView.heightAnchor.constraint(equalToConstant: 118),

            headerConvertibleCurrencyLabel.topAnchor.constraint(equalTo: topBlockContentView.topAnchor, constant: 8),
            headerConvertibleCurrencyLabel.leadingAnchor.constraint(equalTo: topBlockContentView.leadingAnchor,
                                                                    constant: 16),
            headerConvertibleCurrencyLabel.trailingAnchor.constraint(equalTo: topBlockContentView.trailingAnchor,
                                                                     constant: 16),

            blockConvertibleCurrencyView.topAnchor.constraint(equalTo: headerConvertibleCurrencyLabel.bottomAnchor,
                                                              constant: 9),
            blockConvertibleCurrencyView.leadingAnchor.constraint(equalTo: topBlockContentView.leadingAnchor,
                                                                  constant: 16),
            blockConvertibleCurrencyView.trailingAnchor.constraint(equalTo: topBlockContentView.trailingAnchor,
                                                                   constant: -16),
            blockConvertibleCurrencyView.bottomAnchor.constraint(equalTo: headerExchangeCurrenciesLabel.topAnchor,
                                                                 constant: -9),

            countryFlagImageView.leadingAnchor.constraint(equalTo: blockConvertibleCurrencyView.leadingAnchor,
                                                          constant: 8),
            countryFlagImageView.heightAnchor.constraint(equalToConstant: 12),
            countryFlagImageView.widthAnchor.constraint(equalToConstant: 16),
            countryFlagImageView.topAnchor.constraint(equalTo: blockConvertibleCurrencyView.topAnchor, constant: 15),
            countryFlagImageView.bottomAnchor.constraint(equalTo: blockConvertibleCurrencyView.bottomAnchor,
                                                         constant: -15),

            betTextField.topAnchor.constraint(equalTo: blockConvertibleCurrencyView.topAnchor, constant: 2),
            betTextField.trailingAnchor.constraint(equalTo: blockConvertibleCurrencyView.trailingAnchor, constant: -3),
            betTextField.bottomAnchor.constraint(equalTo: blockConvertibleCurrencyView.bottomAnchor, constant: -2),
            betTextField.widthAnchor.constraint(equalToConstant: 124),

            convertibleCurrencyLabel.topAnchor.constraint(equalTo: blockConvertibleCurrencyView.topAnchor,
                                                          constant: 0),
            convertibleCurrencyLabel.leadingAnchor.constraint(equalTo: countryFlagImageView.trailingAnchor,
                                                              constant: 15),
            convertibleCurrencyLabel.trailingAnchor.constraint(equalTo: betTextField.leadingAnchor, constant: -15),

            descriptionConvertibleCurrencyLabel.topAnchor.constraint(equalTo: convertibleCurrencyLabel.bottomAnchor,
                                                                     constant: 0),
            descriptionConvertibleCurrencyLabel.leadingAnchor.constraint(equalTo: convertibleCurrencyLabel.leadingAnchor),
            descriptionConvertibleCurrencyLabel.trailingAnchor.constraint(equalTo:
                convertibleCurrencyLabel.trailingAnchor),

            headerExchangeCurrenciesLabel.topAnchor.constraint(equalTo: topBlockContentView.topAnchor, constant: 88),
            headerExchangeCurrenciesLabel.leadingAnchor.constraint(equalTo: topBlockContentView.leadingAnchor,
                                                                   constant: 16),
            headerExchangeCurrenciesLabel.trailingAnchor.constraint(equalTo: topBlockContentView.trailingAnchor,
                                                                    constant: 16),

        ])

        middleBlockContentView.translatesAutoresizingMaskIntoConstraints = false
        tableWithCurrencyView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            middleBlockContentView.topAnchor.constraint(equalTo: topBlockContentView.bottomAnchor),
            middleBlockContentView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            middleBlockContentView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            middleBlockContentView.bottomAnchor.constraint(equalTo: footterBlockDateReceivedDataView.topAnchor, constant: -16),

            tableWithCurrencyView.topAnchor.constraint(equalTo: middleBlockContentView.topAnchor, constant: 4),
            tableWithCurrencyView.leadingAnchor.constraint(equalTo: middleBlockContentView.leadingAnchor, constant: 0),
            tableWithCurrencyView.trailingAnchor.constraint(equalTo: middleBlockContentView.trailingAnchor,
                                                            constant: -16),
            tableWithCurrencyView.bottomAnchor.constraint(equalTo: middleBlockContentView.bottomAnchor),
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
    func currencyTapped() {
        presenter.showConvertibleCurrencyVCTapButton()
    }

    @objc
    func editTapped() {
        presenter.showCurrencyListVCTapButton()
    }
}

extension ConverterCurrencyView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let value = textField.text else { return false }
        presenter.getAmountConvertibleCurrency(text: value)
        return true
    }
}

extension ConverterCurrencyView: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        guard let list = currencyList else { return 0 }
        return list.items.count
    }

    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        let heightRow: CGFloat = 48
        return heightRow
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableWithCurrencyView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? ConverterCurrencyTableViewCell else { fatalError() }
        guard let model = currencyList else { return cell }
        if let baseCurrency = convertibleCurrency?.currencyKey {
            cell.configure(baseCurrency: baseCurrency, model: model, index: indexPath.row)
        }
        return cell
    }
}

extension ConverterCurrencyView: UITableViewDelegate {}
