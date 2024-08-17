import UIKit

final class ConverterCurrencyTableViewCell: UITableViewCell {
    private enum ConstantConstraint: CGFloat {
        case distanceToSide = 22
        case spacingBetweenContent = 10
        case sizeCountryFlagImageView = 25
        case sizeAnteTextField = 60
        case sizeRightContent = 200
    }

    private var countryFlagImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(systemName: "heart")
        return imageView
    }()

    private var currencyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textColor = .black
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
        label.textAlignment = .right
        return label
    }()

    private var rateCurrencyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        label.textAlignment = .right
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

            currencyLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2),
            currencyLabel.leadingAnchor.constraint(equalTo: countryFlagImageView.trailingAnchor,
                                                   constant: ConstantConstraint.spacingBetweenContent.rawValue),
            currencyLabel.trailingAnchor.constraint(equalTo: totalUnitsCurrencyLabel.leadingAnchor,
                                                    constant: -ConstantConstraint.spacingBetweenContent.rawValue),
            currencyLabel.bottomAnchor.constraint(equalTo: centerYAnchor),

            descriptionCurrencyLabel.topAnchor.constraint(equalTo: centerYAnchor),
            descriptionCurrencyLabel.leadingAnchor.constraint(equalTo: countryFlagImageView.trailingAnchor,
                                                              constant: ConstantConstraint.spacingBetweenContent.rawValue),
            descriptionCurrencyLabel.trailingAnchor.constraint(equalTo: rateCurrencyLabel.leadingAnchor,
                                                               constant: -ConstantConstraint.spacingBetweenContent.rawValue),
            descriptionCurrencyLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),

            totalUnitsCurrencyLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            totalUnitsCurrencyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            totalUnitsCurrencyLabel.leadingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -ConstantConstraint.sizeRightContent.rawValue),
            totalUnitsCurrencyLabel.bottomAnchor.constraint(equalTo: centerYAnchor),

            rateCurrencyLabel.topAnchor.constraint(equalTo: centerYAnchor),
            rateCurrencyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            rateCurrencyLabel.leadingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -ConstantConstraint.sizeRightContent.rawValue),
            rateCurrencyLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),

        ])
    }

    func configure(baseCurrency: CurrencyId, model: ConverterCurrencyView.ConvertibleCurrencyListModel, index: Int) {
        countryFlagImageView.image = model.items[index].flag
        currencyLabel.text = model.items[index].currencyKey
        descriptionCurrencyLabel.text = model.items[index].currencyName
        totalUnitsCurrencyLabel.text = String(model.items[index].amount)
        rateCurrencyLabel.text = String("1 \(baseCurrency) = \(model.items[index].rate) \(model.items[index].currencyKey)")
    }
}
