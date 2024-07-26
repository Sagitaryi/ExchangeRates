import UIKit

final class ConverterCurrencyView: UIView {
    // Модель через которую передают все изменения во View

//    struct ConvertibleCurrencyModel {
//        let flag: UIImage
//        let symbols: SymbolsModel
//        let sum: Double
//    }

    private var convertibleCurrency: ConvertibleCurrencyModel?
    private var currencyList: [ConvertibleCurrencyModel?]?

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
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 5
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
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 5
        textField.layer.borderColor = .init(red: 242, green: 242, blue: 247, alpha: 0.4)
        guard let text = convertibleCurrency?.sum as? String else { return textField }
        textField.text = text
        return textField
    }()

    private lazy var headerExchangeCurrenciesLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 17)
        label.textColor = .gray
        label.text = "To:"
        return label
    }()

    private lazy var bottomBlockContentView: UIView = {
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

    func updateConvertibleCurrency(model: ConvertibleCurrencyModel?) {
        convertibleCurrency = model
        guard let model = model else { return }
        countryFlagImageView.image = model.flag
        convertibleCurrencyLabel.text = model.key
        descriptionConvertibleCurrencyLabel.text = model.value
    }

    func updateListExchangeCurrencies(model: [ConvertibleCurrencyModel?]) {
        currencyList = model

//        convertibleCurrency = model
//        guard let model = convertibleCurrency else { return }
//        countryFlagImageView.image = model.flag
//        convertibleCurrencyLabel.text = model.key
//        descriptionConvertibleCurrencyLabel.text = model.value
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

        addSubview(bottomBlockContentView)
        bottomBlockContentView.addSubview(tableWithCurrencyView)
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

            //            countryFlagImageView.centerYAnchor.constraint(equalTo: blockConvertibleCurrencyView.centerYAnchor),
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
//            betTextField.centerYAnchor.constraint(equalTo: blockConvertibleCurrencyView.centerYAnchor),
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

        bottomBlockContentView.translatesAutoresizingMaskIntoConstraints = false
        tableWithCurrencyView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            bottomBlockContentView.topAnchor.constraint(equalTo: topBlockContentView.bottomAnchor),
            bottomBlockContentView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            bottomBlockContentView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            bottomBlockContentView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),

            tableWithCurrencyView.topAnchor.constraint(equalTo: bottomBlockContentView.topAnchor, constant: 4),
            tableWithCurrencyView.leadingAnchor.constraint(equalTo: bottomBlockContentView.leadingAnchor, constant: 0),
            tableWithCurrencyView.trailingAnchor.constraint(equalTo: bottomBlockContentView.trailingAnchor,
                                                            constant: -16),
            tableWithCurrencyView.bottomAnchor.constraint(equalTo: bottomBlockContentView.bottomAnchor, constant: 80),
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

extension ConverterCurrencyView: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        guard let list = currencyList else { return 0 }
        return list.count
    }

    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return 48
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableWithCurrencyView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? ConverterCurrencyTableViewCell else { fatalError() }

        if let model = currencyList {
            cell.configure(model: model, index: indexPath.row)
        }
        return cell
    }
}

extension ConverterCurrencyView: UITableViewDelegate {
//    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
    ////        guard let isSelected = model?.items[indexPath.row].isSelected else { return }
    ////        model?.items[indexPath.row].isSelected = !isSelected
    ////
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? SelectionCurrencyTableViewCell else { fatalError() }
//        ////
    ////        cell.showCheckBox(isSelected: model?.items[indexPath.row].isSelected ?? false)
//        presenter.tapCell(model: model, index: indexPath.row, cell: cell)
//    }
}
