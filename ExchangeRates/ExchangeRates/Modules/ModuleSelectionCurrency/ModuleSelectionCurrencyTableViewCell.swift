import UIKit

class ModuleSelectionCurrencyTableViewCell: UITableViewCell {
    private enum ConstantConstraint: CGFloat {
        case distanceToSide = 22
        case spacingBetweenContent = 10
        case sizeCheckbox = 20
    }

    private var currency: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()

    private var checkBox: UIImageView = {
        var imageView = UIImageView()
        return imageView
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
        checkBox.translatesAutoresizingMaskIntoConstraints = false

        addSubview(currency)
        addSubview(checkBox)

        NSLayoutConstraint.activate([
            currency.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: ConstantConstraint.distanceToSide.rawValue),
            currency.trailingAnchor.constraint(equalTo: checkBox.leadingAnchor, constant: -ConstantConstraint.spacingBetweenContent.rawValue),
            currency.centerYAnchor.constraint(equalTo: centerYAnchor),
            checkBox.leadingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            checkBox.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -18),
            checkBox.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }

    func configure(item: Item) {
        currency.text = "\(item.key) - \(item.value)"
        showCheckBox(isSelected: item.isSelected)
    }

    func showCheckBox(isSelected: Bool) {
        let nameImage = isSelected ? "checkmark" : ""
        checkBox.image = UIImage(systemName: nameImage)
    }
}
