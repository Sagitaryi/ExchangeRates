import UIKit

final class LoaderView: UIView {
    private let loaderImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "obmen-valut")
        return imageView
    }()

    private let headerLoaderLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Futura-Medium", size: 45)
        label.textColor = .white
        label.text = "CURRENCY"
        return label
    }()

    private let activityIndicator: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.startAnimating()
        return spinner
    }()

    init() {
        super.init(frame: .zero)
        backgroundColor = .systemGray
        setupSubviewLoader()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .systemGray
        setupSubviewLoader()
    }

    private func setupSubviewLoader() {
        addSubview(loaderImageView)
        addSubview(headerLoaderLabel)
        addSubview(activityIndicator)

        setupConstraintsLoader()
    }

    private func setupConstraintsLoader() {
        loaderImageView.translatesAutoresizingMaskIntoConstraints = false
        headerLoaderLabel.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            loaderImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            loaderImageView.bottomAnchor.constraint(equalTo: headerLoaderLabel.topAnchor, constant: -30),
            loaderImageView.widthAnchor.constraint(equalToConstant: 60),
            loaderImageView.heightAnchor.constraint(equalToConstant: 60),

            headerLoaderLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            headerLoaderLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.topAnchor.constraint(equalTo: headerLoaderLabel.bottomAnchor, constant: 30),
            activityIndicator.heightAnchor.constraint(equalToConstant: 80),
            activityIndicator.widthAnchor.constraint(equalToConstant: 80),
        ])
    }
}
