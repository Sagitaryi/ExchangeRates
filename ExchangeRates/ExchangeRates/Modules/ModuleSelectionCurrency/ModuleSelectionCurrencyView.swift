//
//  ModuleSelectionCurrencyView.swift
//  ExchangeRates
//
//  Created by Алексей Чумаков on 07.06.2024.
//

import UIKit

final class ModuleSelectionCurrencyView: UIView {
    // Модель через которую передают все изменения во View
    struct Model {
        let text: String
        let buttonText: String
    }

//    private lazy var editBarButtonItem: UIBarButtonItem = {
//        let barButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editTapped))
//        barButtonItem.tintColor = .label
//        return barButtonItem
//    }()

//    private lazy var button: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("Tap me please!", for: .normal)
//        button.addTarget(self, action: #selector(onTapped), for: .touchUpInside)
//        return button
//    }()
//
//    private lazy var label: UILabel = {
//        let label = UILabel()
//        label.font = .boldSystemFont(ofSize: 25)
//        label.text = "Some ... text"
//        return label
//    }()

    private let presenter: ModuleSelectionCurrencyPresenterProtocol

    init(presenter: ModuleSelectionCurrencyPresenterProtocol) {
        self.presenter = presenter
        super.init(frame: .zero)
        commonInit()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update(model _: Model) {
//        label.text = model.text
//        button.setTitle(model.buttonText, for: .normal)
    }

//    func addButtonEditNavBar() -> UIBarButtonItem {
//        return editBarButtonItem
//    }

    func showError() {
        // Показываем View ошибки
    }

    func showEmpty() {
        // Показываем какой-то View для Empty state
    }

    func startLoader() {
        // Показываем скелетон или лоадер
    }

    func stopLoader() {
        // Скрываем все
    }
}

private extension ModuleSelectionCurrencyView {
    func commonInit() {
        backgroundColor = .white
        setupSubviews()
        setupConstraints()
    }

    func setupSubviews() {
//        addSubview(button)
//        addSubview(label)
//        addSubview(navBar)
    }

    func setupConstraints() {
//        button.translatesAutoresizingMaskIntoConstraints = false
//        label.translatesAutoresizingMaskIntoConstraints = false
//        navBar.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            //            button.heightAnchor.constraint(equalToConstant: 45.0),
//            button.widthAnchor.constraint(equalToConstant: 150.0),
//            button.centerXAnchor.constraint(equalTo: centerXAnchor),
//            button.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20.0),
//
//            label.centerYAnchor.constraint(equalTo: centerYAnchor),
//            label.centerXAnchor.constraint(equalTo: centerXAnchor),

//            navBar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 0),
//            navBar.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 0),
//            navBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
//            navBar.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 92),
//            heightAnchor.constraint(equalToConstant: 92.0),
//            navBar.widthAnchor.constraint(equalToConstant: 390.0),
//            navBar.centerXAnchor.constraint(equalTo: centerXAnchor),
//            navBar.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0.0),
        ])
    }

//    @objc
//    func onTapped() {
    ////        presenter.tapButton()
//    }

//    @objc
//    func editTapped() {
//        presenter.showNextVCTapButton()
//    }
}
