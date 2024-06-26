import UIKit

class ModuleSelectionCurrencyTableViewCell: UITableViewCell {
    
    // TODO: на static let ...
    private enum ConstantConstraint: CGFloat {
        case distanceToSide = 22
        case spacingBetweenContent = 10
        case sizeCheckbox = 20
        
        // static let x = 10
    }
    
    private var currencyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()

    private var checkBoxImageView: UIImageView = {
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

    // TODO: В private extension
    private func setupCell() {
        currencyLabel.translatesAutoresizingMaskIntoConstraints = false
        checkBoxImageView.translatesAutoresizingMaskIntoConstraints = false

        // TODO: в content View
        addSubview(currencyLabel)
        addSubview(checkBoxImageView)

        NSLayoutConstraint.activate([
            currencyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: ConstantConstraint.distanceToSide.rawValue),
            currencyLabel.trailingAnchor.constraint(equalTo: checkBoxImageView.leadingAnchor, constant: -ConstantConstraint.spacingBetweenContent.rawValue),
            currencyLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            checkBoxImageView.leadingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            checkBoxImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -18),
            checkBoxImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }

    func configure(item: Item) {
        currencyLabel.text = "\(item.key) - \(item.value)"
        showCheckBox(isSelected: item.isSelected)
    }

    func showCheckBox(isSelected: Bool) {
        let nameImage = isSelected ? "checkmark" : ""
        checkBoxImageView.image = UIImage(systemName: nameImage)
    }
}
