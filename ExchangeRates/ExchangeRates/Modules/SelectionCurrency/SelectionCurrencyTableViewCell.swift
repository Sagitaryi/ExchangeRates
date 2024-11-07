import UIKit

typealias SelectionModel = SelectionCurrencyTableViewCell.Model

final class SelectionCurrencyTableViewCell: UITableViewCell {
    static let id = "SelectionCurrencyTableViewCell"

    struct Model: Hashable {
        let currencyFullName: String
        let currencyKey: String
        let currencyName: String
        var isSelected: Bool
    }

    private var currencyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
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

    func configure(with model: Model) {
        currencyLabel.text = model.currencyFullName
        accessoryType = model.isSelected ? .checkmark : .none
    }
}

private extension SelectionCurrencyTableViewCell {
    private enum ConstantConstraint {
        static let distanceToSide: CGFloat = 22
        static let spacingBetweenContent: CGFloat = 10
        static let sizeCheckbox: CGFloat = 20
    }

    private func setupCell() {
        currencyLabel.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(currencyLabel)

        NSLayoutConstraint.activate([
            currencyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                   constant: ConstantConstraint.distanceToSide),
            currencyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                    constant: -ConstantConstraint.spacingBetweenContent),
            currencyLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
