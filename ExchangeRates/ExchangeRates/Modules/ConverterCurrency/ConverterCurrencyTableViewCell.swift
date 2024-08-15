import UIKit

final class ConverterCurrencyTableViewCell: UITableViewCell {
    private enum ConstantConstraint: CGFloat {
        case distanceToSide = 22
        case spacingBetweenContent = 10
        case sizeCountryFlagImageView = 25
        case sizeAnteTextField = 60
    }

    private var countryFlagImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(systemName: "heart")
        return imageView
    }()

    private var currencyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
//        label.backgroundColor = .blue
        label.textColor = .black
//        label.textAlignment
//        label.contentMode = .bottomRight
        return label
    }()

    private var descriptionCurrencyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .lightGray
        return label
    }()

    private var totalUnitsCurrencyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .black
        return label
    }()

    private var rateCurrencyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        return label
    }()

//    var betTextField: UITextField = {
//        let textField = UITextField()
//        textField.placeholder = "6656"
    ////        textField.delegate = textField
//        return textField
//    }()

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
        totalUnitsCurrencyLabel.translatesAutoresizingMaskIntoConstraints = false
        rateCurrencyLabel.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(countryFlagImageView)
        contentView.addSubview(currencyLabel)
        contentView.addSubview(descriptionCurrencyLabel)
        contentView.addSubview(totalUnitsCurrencyLabel)
        contentView.addSubview(rateCurrencyLabel)

        NSLayoutConstraint.activate([
            countryFlagImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: ConstantConstraint.distanceToSide.rawValue),
            countryFlagImageView.heightAnchor.constraint(equalToConstant: 20),
            countryFlagImageView.widthAnchor.constraint(equalToConstant: ConstantConstraint.sizeCountryFlagImageView.rawValue),
            countryFlagImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
//
            totalUnitsCurrencyLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            totalUnitsCurrencyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            totalUnitsCurrencyLabel.leadingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -100),
            totalUnitsCurrencyLabel.bottomAnchor.constraint(equalTo: centerYAnchor),

            rateCurrencyLabel.topAnchor.constraint(equalTo: centerYAnchor),
            rateCurrencyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            rateCurrencyLabel.leadingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -100),
            rateCurrencyLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),

            currencyLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2),
            currencyLabel.leadingAnchor.constraint(equalTo: countryFlagImageView.trailingAnchor,
                                                   constant: ConstantConstraint.spacingBetweenContent.rawValue),
            currencyLabel.trailingAnchor.constraint(equalTo: rateCurrencyLabel.leadingAnchor,
                                                    constant: ConstantConstraint.distanceToSide.rawValue),
            currencyLabel.bottomAnchor.constraint(equalTo: centerYAnchor),
//
            descriptionCurrencyLabel.topAnchor.constraint(equalTo: centerYAnchor),
            descriptionCurrencyLabel.leadingAnchor.constraint(equalTo: countryFlagImageView.trailingAnchor,
                                                              constant: ConstantConstraint.spacingBetweenContent.rawValue),
            descriptionCurrencyLabel.trailingAnchor.constraint(equalTo: rateCurrencyLabel.leadingAnchor,
                                                               constant: ConstantConstraint.distanceToSide.rawValue),
            descriptionCurrencyLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),

        ])
    }

    func configure(model: ConverterCurrencyView.ConvertibleCurrencyListModel, index: Int) {
//        if let model = model[index] {
        countryFlagImageView.image = model.items[index].flag
        currencyLabel.text = model.items[index].currencyKey
        descriptionCurrencyLabel.text = model.items[index].currencyName
        totalUnitsCurrencyLabel.text = String(model.items[index].amount)
//            guard let rate = model.rate else { return }
        rateCurrencyLabel.text = String(model.items[index].rate)
//        }

//
//        if let dsfg = model.rates[index].flag {
//            countryFlagImageView.image = dsfg /* model.rates[index].flag */
//        }
//        currencyLabel.text = model.rates[index].key
//        descriptionCurrencyLabel.text = model.rates[index].value
//        totalUnitsCurrencyLabel.text = String(model.rates[index].quantity)
//        rateCurrencyLabel.text = String(model.rates[index].rate)

//        let dsf = model.rates[index].keys
//        let fdg = dsf.first
//        currencyLabel.text = item
//        showCheckBox(isSelected: item.isSelected)
    }

    func showCheckBox(isSelected _: Bool) {
//        let nameImage = isSelected ? "checkmark" : ""
//        checkBox.image = UIImage(systemName: nameImage)
    }
}
