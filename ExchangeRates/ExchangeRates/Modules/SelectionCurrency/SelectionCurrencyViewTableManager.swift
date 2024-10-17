import UIKit

final class SelectionCurrencyViewTableManager: NSObject {
    private weak var tableView: UITableView?
    private var items: [SelectionCurrencyTableViewCell.Model]?

    var onTapped: ((_ indexPath: IndexPath) -> Void)?

    func set(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self

        self.tableView = tableView
    }

    func bind(items: [SelectionCurrencyTableViewCell.Model]) {
        self.items = items
        tableView?.reloadData()
    }
}

extension SelectionCurrencyViewTableManager: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        onTapped?(indexPath)
    }
}

extension SelectionCurrencyViewTableManager: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        items?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row

        guard let items = items, items.indices.contains(row), let cell = tableView.dequeueReusableCell(withIdentifier: SelectionCurrencyTableViewCell.id) as? SelectionCurrencyTableViewCell else {
            return UITableViewCell()
        }

        let item = items[row]

        let cellModel = SelectionCurrencyTableViewCell.Model(
            currencyFullName: item.currencyFullName,
            currencyKey: item.currencyKey,
            currencyName: item.currencyName,
            isSelected: item.isSelected
        )
        cell.configure(with: cellModel)
        return cell
    }
}
