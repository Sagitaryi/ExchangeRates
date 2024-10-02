import UIKit

typealias Item = SelectionCurrencyView.Model.Item

final class SelectionCurrencyView: UIView {
    struct Model {
        var items: [Item]

        struct Item {
            let currencyKey: String
            let currencyName: String
            var isSelected: Bool
        }
    }

    private var model: Model?

    private lazy var tableView: UITableView = {
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
}

extension SelectionCurrencyView: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return model?.items.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as?
            SelectionCurrencyTableViewCell else { fatalError() }

        guard let item = model?.items[indexPath.row] else { return UITableViewCell() }
        cell.configure(item: item)
        if item.isSelected {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
}

extension SelectionCurrencyView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.tapCell(index: indexPath.row)
    }
}
