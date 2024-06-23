//
//  ModuleSelectionCurrencyView.swift
//  ExchangeRates
//
//  Created by Алексей Чумаков on 07.06.2024.
//

import UIKit

typealias Item = ModuleSelectionCurrencyView.Model.Item

final class ModuleSelectionCurrencyView: UIView {
    // Модель через которую передают все изменения во View

    struct Model {
        let items: [Item]

        struct Item {
            let key: String
            let value: String
            let isSelected: Bool
        }
    }

    private var model: Model?

    lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(ModuleSelectionCurrencyTableViewCell.self, forCellReuseIdentifier: "Cell")
        table.delegate = self
        table.dataSource = self
        return table
    }()

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

    func update(model: Model) {
        self.model = model
        tableView.reloadData()
    }

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
        addSubview(tableView)
    }

    func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
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

extension ModuleSelectionCurrencyView: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return model?.items.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? ModuleSelectionCurrencyTableViewCell else { fatalError() }

        guard let item = model?.items[indexPath.row] else { return UITableViewCell() }
        cell.configure(item: item)
        return cell
    }
}

extension ModuleSelectionCurrencyView: UITableViewDelegate {}
