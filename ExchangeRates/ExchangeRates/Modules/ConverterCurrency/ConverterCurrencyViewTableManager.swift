import UIKit

final class ConverterCurrencyViewTableManager: NSObject {
    var onTapped: ((_ indexPath: IndexPath) -> Void)?

    private weak var tableView: UITableView?
    private var items: [ConverterCurrencyModel]?
    private var diffableDataSource: UITableViewDiffableDataSource<Int, ConverterCurrencyModel>?

    func set(tableView: UITableView) {
        tableView.delegate = self
        self.tableView = tableView
        setupDifableDataSource()
    }

    func updateDiffableDataSource() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, ConverterCurrencyModel>()
        snapshot.appendSections([0])
        guard let items = items else { return }
        snapshot.appendItems(items)
        diffableDataSource?.apply(snapshot, animatingDifferences: false)
    }

    func bind(items: [ConverterCurrencyTableViewCell.Model]) {
        self.items = items
        updateDiffableDataSource()
    }
}

extension ConverterCurrencyViewTableManager: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        onTapped?(indexPath)
    }
}

extension ConverterCurrencyViewTableManager: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        items?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row

        guard let items = items, items.indices.contains(row), let cell = tableView.dequeueReusableCell(withIdentifier: ConverterCurrencyTableViewCell.id) as? ConverterCurrencyTableViewCell else {
            return UITableViewCell()
        }

        let item = items[row]

        let cellModel = ConverterCurrencyTableViewCell.Model(
            baseCurrency: item.baseCurrency,
            flag: item.flag,
            currencyKey: item.currencyKey,
            currencyName: item.currencyName,
            amount: item.amount,
            rate: item.rate
        )
        
        cell.configure(with: cellModel)
        return cell
    }
}
