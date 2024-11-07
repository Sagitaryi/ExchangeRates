import UIKit

final class SelectionCurrencyViewTableManager: NSObject {
    var onTapped: ((_ indexPath: IndexPath) -> Void)?

    private weak var tableView: UITableView?
    private var items: [SelectionCurrencyTableViewCell.Model]?
    private var diffableDataSource: UITableViewDiffableDataSource<Int, SelectionModel>?

    func set(tableView: UITableView) {
        tableView.delegate = self
        self.tableView = tableView
        setupDifableDataSource()
    }

    func updateDiffableDataSource() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, SelectionModel>()
        snapshot.appendSections([0])
        guard let items = items else { return }
        snapshot.appendItems(items)
        diffableDataSource?.apply(snapshot, animatingDifferences: false)
    }

    func bind(items: [SelectionCurrencyTableViewCell.Model]) {
        self.items = items
        updateDiffableDataSource()
    }
}

extension SelectionCurrencyViewTableManager: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        onTapped?(indexPath)
    }
}

private extension SelectionCurrencyViewTableManager {
    func setupDifableDataSource() {
        guard let tableView = tableView else { return }
        diffableDataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, _ in
            let row = indexPath.row
            guard let items = self.items,
                  items.indices.contains(row), let cell = tableView.dequeueReusableCell(withIdentifier: SelectionCurrencyTableViewCell.id) as? SelectionCurrencyTableViewCell
            else {
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
        })
    }
}
