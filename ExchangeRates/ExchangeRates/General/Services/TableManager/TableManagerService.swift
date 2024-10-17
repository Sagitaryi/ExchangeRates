//
//  TableManagerService.swift
//  ExchangeRates
//
//  Created by Алексей Чумаков on 24.06.2024.
//

import UIKit

/*
 protocol TableManagerServiceProtocol {
     func attachTable(_ tableView: UITableView)
     func displayConverterCurrencyTableView(modelsViewCell: [ConverterCurrencyTableViewCell.Model])}

 final class TableManagerService: NSObject, TableManagerServiceProtocol {
     // MARK: - Private properties

     private var table: UITableView?
     private var configuratorsDataSource: [ConfiguratorCell] = []

     // MARK: - Callbacks

     // MARK: - Public functions

     func attachTable(_ tableView: UITableView) {
         table = tableView
         table?.delegate = self
         table?.dataSource = self
 //           setupTable()
     }

     func displayConverterCurrencyTableView(modelsViewCell: [ConverterCurrencyTableViewCell.Model]) {

         let output: [ConfiguratorCell] = modelsViewCell.compactMap { createConverterCurrencyConfigurator(with:
             .init(baseCurrency: $0.baseCurrency,
                   flag: $0.flag,
                   currencyKey: $0.currencyKey,
                   currencyName: $0.currencyName,
                   amount: $0.amount,
                   rate: $0.rate)) }

         configuratorsDataSource = output

         table?.reloadData()
     }

     // MARK: - Private functions

     //      func setupTable() {
     //          guard let view = viewController?.view else { return }
     //          guard let tableView = self.table else { return }
     //          view.addSubview(tableView)
     //          tableView.translatesAutoresizingMaskIntoConstraints = false
     //
     //          NSLayoutConstraint.activate([
     //              tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
     //              tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
     //              tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
     //              tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
     //          ])
     //      }

     private func createConverterCurrencyConfigurator(with model: ConverterCurrencyTableViewCell.Model) -> ConfiguratorCell {
         let configurator = ConverterCurrencyConfigurator()
         configurator.model = model
         return configurator
     }

 //       private func createFlagConfigurator(with model: FlagCountryModel) -> Configurator {
 //           let configurator = FlagConfigurator()
 //         configurator.model = model
 //         return configurator
 //       }
 }

 extension TableManagerService: UITableViewDelegate {
     func tableView(_: UITableView, didSelectRowAt _: IndexPath) {
         print("adsf")
     }
 }

 extension TableManagerService: UITableViewDataSource {
     func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
 //        print(configuratorsDataSource)
         return configuratorsDataSource.count
     }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let configurator = configuratorsDataSource[indexPath.row]
         configurator.registerCell(in: tableView)
         let cell = tableView.dequeueReusableCell(withIdentifier: "\(configurator.reuseId)", for: indexPath)
         configurator.setupCell(cell)
         return cell
     }
 }
 */
