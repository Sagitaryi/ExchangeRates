import UIKit

typealias Item = SelectionCurrencyView.Model.Item

final class SelectionCurrencyView: UIView {
    // Модель через которую передают все изменения во View
    struct Model {
        var items: [Item]

        struct Item {
            let key: String
            let value: String
            var isSelected: Bool
        }
    }

    private var model: Model?

    lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(SelectionCurrencyTableViewCell.self, forCellReuseIdentifier: "Cell")
        table.delegate = self
        table.dataSource = self
        return table
    }()

    private let presenter: SelectionCurrencyPresenterProtocol

    init(presenter: SelectionCurrencyPresenterProtocol) {
        self.presenter = presenter
        super.init(frame: .zero)
        commonInit()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update(model: Model) {
        self.model = model
        tableView.reloadData()
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

private extension SelectionCurrencyView {
    func commonInit() {
        backgroundColor = .white
        setupSubviews()
        setupConstraints()
    }

    func setupSubviews() {
        addSubview(tableView)
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

//    @objc
//    func editTapped() {
//        presenter.showNextVCTapButton()
//    }
}

extension SelectionCurrencyView: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return model?.items.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? SelectionCurrencyTableViewCell else { fatalError() }

        guard let item = model?.items[indexPath.row] else { return UITableViewCell() }
        cell.configure(item: item)
        return cell
    }
}

extension SelectionCurrencyView: UITableViewDelegate {
    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard let isSelected = model?.items[indexPath.row].isSelected else { return }
//        model?.items[indexPath.row].isSelected = !isSelected
//
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? SelectionCurrencyTableViewCell else { fatalError() }
        ////
//        cell.showCheckBox(isSelected: model?.items[indexPath.row].isSelected ?? false)

        // TODO: это не верно
        // presenter.tapCell( просто ячейку index)
        presenter.tapCell(model: model, index: indexPath.row, cell: cell)
    }
}
