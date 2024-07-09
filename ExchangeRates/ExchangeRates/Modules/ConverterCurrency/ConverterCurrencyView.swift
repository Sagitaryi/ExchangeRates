import UIKit

final class ConverterCurrencyView: UIView {
    // Модель через которую передают все изменения во View
    struct Model {
        let text: String
        let buttonText: String
    }

    private lazy var editBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editTapped))
//        barButtonItem.tintColor = .label
        return barButtonItem
    }()

    lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(ConverterCurrencyTableViewCell.self, forCellReuseIdentifier: "Cell")
        table.delegate = self
        table.dataSource = self
        return table
    }()

//    private lazy var label: UILabel = {
//        let label = UILabel()
//        label.font = .boldSystemFont(ofSize: 25)
//        label.text = "Some ... text"
//        return label
//    }()

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

    func update(model _: Model) {
//        label.text = model.text
//        button.setTitle(model.buttonText, for: .normal)
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
        addSubview(tableView)
//        addSubview(button)
//        addSubview(label)
//        addSubview(navBar)
    }

    func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
        ])
    }

//    @objc
//    func onTapped() {
    ////        presenter.tapButton()
//    }

    @objc
    func editTapped() {
        presenter.showNextVCTapButton()
    }
}

extension ConverterCurrencyView: UITableViewDataSource {
    func numberOfSections(in _: UITableView) -> Int {
        return 2
    }

    func tableView(_: UITableView, titleForHeaderInSection section: Int) -> String? {
        let nameSection: String
        switch section {
        case 0:
            nameSection = "From:"
        case 1:
            nameSection = "To:"
        default:
            nameSection = ""
        }
        return nameSection
    }

    func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRows: Int
        switch section {
        case 0:
            numberOfRows = 1
        case 1:
            numberOfRows = 5
        default:
            numberOfRows = 0
        }
        return numberOfRows
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? ConverterCurrencyTableViewCell else { fatalError() }
//        cell.anteTextField.delegate = self
//        guard let item = model?.items[indexPath.row] else { return UITableViewCell() }
        cell.configure(item: "DFh")
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
