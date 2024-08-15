import UIKit

final class SelectionCurrencyTableViewCell: UITableViewCell {
    private var currencyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()

//    private var checkBoxImageView: UIImageView = {
//        var imageView = UIImageView()
//        return imageView
//    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(item: Item) {
        currencyLabel.text = "\(item.currencyKey) - \(item.currencyName)"
//        showCheckBox(isSelected: item.isSelected)
    }

    func showCheckBox(isSelected _: Bool) {
//        let nameImage = isSelected ? "checkmark" : ""
//        checkBoxImageView.image = UIImage(systemName: nameImage)
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
//        checkBoxImageView.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(currencyLabel)
//        contentView.addSubview(checkBoxImageView)

        NSLayoutConstraint.activate([
            currencyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                   constant: ConstantConstraint.distanceToSide),
            currencyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                    constant: -ConstantConstraint.spacingBetweenContent),
            currencyLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
//            checkBoxImageView.leadingAnchor.constraint(equalTo: contentView.trailingAnchor,
//                                                       constant: -(ConstantConstraint.distanceToSide +
//                                                           ConstantConstraint.sizeCheckbox)),
//            checkBoxImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
//                                                        constant: -ConstantConstraint.distanceToSide),
//            checkBoxImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
