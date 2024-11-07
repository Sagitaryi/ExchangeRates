import UIKit

final class SelectionCurrencyView: UIView {
    struct Model {
        let items: [SelectionModel]
    }

    private let tableManager = SelectionCurrencyViewTableManager()

    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(
            SelectionCurrencyTableViewCell.self,
            forCellReuseIdentifier: SelectionCurrencyTableViewCell.id
        )
        table.separatorInset = .zero
        table.tableFooterView = UIView()
        table.backgroundColor = .systemBackground
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false

        tableManager.set(tableView: table)
        tableManager.onTapped = { [weak self] index in
            self?.presenter.tapRow(index: index.row)
        }
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
        tableManager.bind(items: model.items)
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
