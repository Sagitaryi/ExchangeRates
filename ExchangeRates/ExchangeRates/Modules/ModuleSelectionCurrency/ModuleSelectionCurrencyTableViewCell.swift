import UIKit

class ModuleSelectionCurrencyTableViewCell: UITableViewCell {
    var currency: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupCell() {
        currency.translatesAutoresizingMaskIntoConstraints = false
        addSubview(currency)
        NSLayoutConstraint.activate([
            currency.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            currency.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            currency.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }

    func configure(item: Item) {
        currency.text = "\(item.key) - \(item.value)"
    }

//    func configure(symbols: String) {
//        currency.text = symbols
//    }
}
