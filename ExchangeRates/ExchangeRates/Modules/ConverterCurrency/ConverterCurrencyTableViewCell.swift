import UIKit

class ConverterCurrencyTableViewCell: UITableViewCell {
    private enum ConstantConstraint: CGFloat {
        case distanceToSide = 22
        case spacingBetweenContent = 10
        case sizeCountryFlagImageView = 20
        case sizeAnteTextField = 60
    }

    private var countryFlagImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(systemName: "heart")
        return imageView
    }()

    private var currencyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()

    private var descriptionCurrencyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .black
        return label
    }()

    var anteTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "6656"
//        textField.delegate = textField
        return textField
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
        countryFlagImageView.translatesAutoresizingMaskIntoConstraints = false
        currencyLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionCurrencyLabel.translatesAutoresizingMaskIntoConstraints = false
        anteTextField.translatesAutoresizingMaskIntoConstraints = false

        addSubview(countryFlagImageView)
        addSubview(currencyLabel)
//        addSubview(descriptionCurrencyLabel)
        addSubview(anteTextField)

        NSLayoutConstraint.activate([
            countryFlagImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: ConstantConstraint.distanceToSide.rawValue),
            countryFlagImageView.widthAnchor.constraint(equalToConstant: ConstantConstraint.sizeCountryFlagImageView.rawValue),
            countryFlagImageView.centerYAnchor.constraint(equalTo: centerYAnchor),

            anteTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -ConstantConstraint.distanceToSide.rawValue),
            anteTextField.widthAnchor.constraint(equalToConstant: ConstantConstraint.sizeAnteTextField.rawValue),
            anteTextField.leadingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -(ConstantConstraint.distanceToSide.rawValue + ConstantConstraint.sizeAnteTextField.rawValue)),
            anteTextField.centerYAnchor.constraint(equalTo: centerYAnchor),

            currencyLabel.leadingAnchor.constraint(equalTo: countryFlagImageView.trailingAnchor, constant: ConstantConstraint.spacingBetweenContent.rawValue),
            currencyLabel.trailingAnchor.constraint(equalTo: anteTextField.leadingAnchor, constant: ConstantConstraint.distanceToSide.rawValue),
            currencyLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

//            descriptionCurrencyLabel.leadingAnchor.constraint(equalTo: countryFlagImageView.trailingAnchor, constant: ConstantConstraint.spacingBetweenContent.rawValue),
//            descriptionCurrencyLabel.rightAnchor.constraint(equalTo: anteTextField.leadingAnchor, constant: ConstantConstraint.distanceToSide.rawValue),

//            currency.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: ConstantConstraint.distanceToSide.rawValue),
//            currency.trailingAnchor.constraint(equalTo: checkBox.leadingAnchor, constant: -ConstantConstraint.spacingBetweenContent.rawValue),
//            currency.centerYAnchor.constraint(equalTo: centerYAnchor),
//            checkBox.leadingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
//            checkBox.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -18),
//            checkBox.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
//        print(anteTextField.leadingAnchor)
    }

    func configure(item: String) {
        currencyLabel.text = item
//        showCheckBox(isSelected: item.isSelected)
    }

    func showCheckBox(isSelected _: Bool) {
//        let nameImage = isSelected ? "checkmark" : ""
//        checkBox.image = UIImage(systemName: nameImage)
    }
}
