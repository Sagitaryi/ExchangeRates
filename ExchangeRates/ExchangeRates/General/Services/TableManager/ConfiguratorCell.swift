import UIKit

/*
 enum CatalogCellType {
     // ячейка с
     case converterCurrencyCell
     // ячейка с
     case flagCell
     // ячейка с
     case populationCell
 }

 protocol ConfiguratorCell {
     // переменная для ячейки с reuse id
     var reuseId: UITableViewCell.Type { get }
     // тип ячейки для последующей отработки нажатия на ячейку
     var cellType: CatalogCellType { get }
     // настройка ячейки
     func setupCell(_ cell: UIView)
     func registerCell(in tableView: UITableView)
 }

 final class ConverterCurrencyConfigurator: ConfiguratorCell {
     var reuseId: UITableViewCell.Type = ConverterCurrencyTableViewCell.self
     // тип ячейки для обработки события
     var cellType: CatalogCellType { .converterCurrencyCell }
     // модель данных для отображения в ячейке
     var model: ConverterCurrencyTableViewCell.Model?

     // метод конфигурирования ячейки
     func setupCell(_ cell: UIView) {
         guard let cell = cell as? ConverterCurrencyTableViewCell,
               let converterCurrencyModel = model else { return }
         cell.configure(model: converterCurrencyModel)
     }

     func registerCell(in tableView: UITableView) {
         tableView.register(reuseId, forCellReuseIdentifier: "\(reuseId)")
     }
 }

 // final class FlagConfigurator: Configurator {
 //    var reuseId: UITableViewCell.Type = FlagTableViewCell.self
 //    // тип ячейки для обработки события
 //    var cellType: CountryCatalogCellType { .flagCell }
 //    // модель данных для отображения в ячейке
 //    var model: FlagCountryModel?
 //
 //    // метод конфигурирования ячейки
 //    func setupCell(_ cell: UIView) {
 //        guard let cell = cell as? FlagTableViewCell,
 //              let nameModel = model else { return print("fail") }
 //        print(true)
 //        let viewCellModel = FlagTableViewCell.model.init(flag: nameModel.flag, gerb: nameModel.gerb)
 //        cell.configure(with: viewCellModel )
 //    }

 //        func registerCell(in tableView: UITableView) {
 //                    tableView.register(self.reuseId, forCellReuseIdentifier: "\(reuseId)")
 //        }
 // }

 //
 //    func generate(tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
 //        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(reuseId)", for: indexPath) as? NameTableViewCell else {
 //                    return UITableViewCell()
 //                }
 //
 ////                self.build(view: cell)
 //
 //                return cell
 //    }
 //
 //    func registerCell(in tableView: UITableView) {
 //                tableView.register(self.reuseId, forCellReuseIdentifier: "\(reuseId)")
 //    }

 /*
  final class FlagConfigurator: Configurator {
    // reuse id для таблицы который соответствует ячейке
      var reuseId: String { String(describing: FlagTableViewCell.self) }
    // тип ячейки для обработки события
      var cellType: CountryCatalogCellType { .flagCell }
    // модель данных для отображения в ячейке
    var model: FlagCountryModel?

    // метод конфигурирования ячейки
    func setupCell(_ cell: UIView) {
      guard let cell = cell as? FlagTableViewCell,
                  let flagModel = model else { return }
      // предположим, чтобы не вдаваться в детали, что в ячейке
      // имеется метод, который уже отоборажает все данные на ней.
        cell.configure(with: "Flag")
    }
  }

  final class PopulationConfigurator: Configurator {
    // reuse id для таблицы который соответствует ячейке
      var reuseId: String { String(describing: PopulationTableViewCell.self) } // FIXME: заменить на класс его ячейки
    // тип ячейки для обработки события
      var cellType: CountryCatalogCellType { .populationCell }
    // модель данных для отображения в ячейке
      var model: PopulationCountryModel?

    // метод конфигурирования ячейки
    func setupCell(_ cell: UIView) {
      guard let cell = cell as? PopulationTableViewCell,
                  let populationModel = model else { return }
      // предположим, чтобы не вдаваться в детали, что в ячейке
      // имеется метод, который уже отоборажает все данные на ней.
        cell.configure(with: "235346")
    }*/

 /*
  enum CatalogCellType {
    // ячейка с запросом из истории поиска
    case historyCell
    // ячейка с продуктом, найденным в каталоге
    case productCell
    // ячейка с найденной категорией
    case categoryCell
  }

  protocol Configurator2 {
    // переменная для ячейки с reuse id
      var reuseId: String { get }
    // тип ячейки для последующей отработки нажатия на ячейку
    var cellType: CatalogCellType { get }

  //    var model: CatalogSectionModel? { get }
    // настройка ячейки
      func setupCell(_ cell: UIView)
  }

  // конфигуратор для ячеек с поисковой выдачей по найденным продуктам
  final class SearchProductConfigurator: Configurator2 {

    // reuse id для таблицы который соответствует ячейке
      var reuseId: String { String(describing: MyTableViewCell.self) }
    // тип ячейки для обработки события
      var cellType: CatalogCellType { .productCell }
    // модель данных для отображения в ячейке
    var model: SearchProductModel?

    // метод конфигурирования ячейки
    func setupCell(_ cell: UIView) {
      guard let cell = cell as? SearchProductCellProtocol,
                  let productModel = model else { return }
      // предположим, чтобы не вдаваться в детали, что в ячейке
      // имеется метод, который уже отоборажает все данные на ней.
      cell.displayData(productModel: productModel)
    }

  }

  // конфигуратор для ячеек с поисковой выдачей по категориям продуктов
  final class SearchSectionConfigurator: Configurator2 {

    // reuse id для таблицы который соответствует ячейке
      var reuseId: String = "SearchSectionCell"
    // тип ячейки для обработки события
      var cellType: CatalogCellType { .categoryCell }
    // модель данных для отображения в ячейке
    var model: CatalogSectionModel?

    // метод конфигурирования ячейки
    func setupCell(_ cell: UIView) {
      guard let cell = cell as? SearchSectionCellCellProtocol,
                  let sectionModel = model else { return }
      // предположим, чтобы не вдаваться в детали, что в ячейке
      // имеется метод, который уже отоборажает все данные на ней.
      cell.displayData(sectionModel: sectionModel)
    }

  }

  // конфигуратор для ячеек с предыдущей поисковой выдачей
  final class SearchPreviousRequestConfigurator: Configurator2 {

    // reuse id для таблицы который соответствует ячейке
      var reuseId: String = "SearchPreviousCell"
    // тип ячейки для обработки события
      var cellType: CatalogCellType { .historyCell }
    // текст поискового запрос для отображения в ячейке
    var model: String?

    // метод конфигурирования ячейки
    func setupCell(_ cell: UIView) {
      guard let cell = cell as? SearchPreviousCellProtocol,
                  let searchModel = model else { return }
      // предположим, чтобы не вдаваться в детали, что в ячейке
      // имеется метод, который уже отоборажает все данные на ней.
      cell.displayData(searchModel: searchModel)
    }

  }

  */

 //// перечисляем все виды ячеек
 // enum CatalogCellType {
 //  // ячейка с названием валюты
 //  case labelCell
 //  // ячейка с флагом страны валюты
 //  case imageCell
 //  // ячейка с количеством валюты
 //  case textFieldCell
 // }
 //
 //// объявляем протокол для конфигураторов ячеек
 // protocol Configurator {
 //  // переменная для ячейки с reuse id
 //    var reuseId: String { get }
 //  // тип ячейки для последующей отработки нажатия на ячейку
 //  var cellType: CatalogCellType { get }
 //  // настройка ячейки
 //    func setupCell(_ cell: UIView)
 // }
 //
 //// конфигуратор для ячеек с названием валюты
 // final class CurrencyNameConfigurator: Configurator {
 //    // reuse id для таблицы который соответствует ячейке
 ////      var reuseId: String { String(describing: SearchProductCell.self) }
 //
 //    var reuseId: String
 //    // тип ячейки для обработки события
 //      var cellType: CatalogCellType { .labelCell }
 //    // модель данных для отображения в ячейке
 //    var model: SearchProductModel?
 //
 //    // метод конфигурирования ячейки
 //    func setupCell(_ cell: UIView) {
 //      guard let cell = cell as? SearchProductCellProtocol,
 //                  let productModel = model else { return }
 //      // предположим, чтобы не вдаваться в детали, что в ячейке
 //      // имеется метод, который уже отоборажает все данные на ней.
 //      cell.displayData(productModel: productModel)
 //    }
 //
 //
 //
 //
 //
 //        // наполняем ячейку контентом
 //        private var myLabel: UILabel = {
 //            let label = UILabel()
 //            label.font = UIFont.boldSystemFont(ofSize: 17)
 //            label.textColor = .black
 //            return label
 //        }()
 //
 //        // выбираем для ячейки стиль и "многоразовый" идентификатор, тут же запускаем установку ячейки(констрейнты)
 //        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
 //            super.init(style: style, reuseIdentifier: reuseIdentifier)
 //            setupCell()
 //        }
 //
 //        required init?(coder: NSCoder) {
 //            fatalError("init(coder:) has not been implemented")
 //        }
 //        // передаем необходимые данные в формате строки для отображения в ячейках
 //        func configure(with text: String ) {
 //            myLabel.text = text
 //            }
 //
 //        func setupCell() {
 //            contentView.addSubview(myLabel)
 //            myLabel.translatesAutoresizingMaskIntoConstraints = false
 //
 //            NSLayoutConstraint.activate([
 //                myLabel.topAnchor.constraint(equalTo: topAnchor),
 //                myLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
 //                myLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
 //                myLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
 //            ])
 //        }
 // }
 //
 //// конфигуратор для ячеек с флагом страны валюты
 // final class CountryFlagConfigurator: Configurator {
 //
 //  // reuse id для таблицы который соответствует ячейке
 //    var reuseId: String { String(describing: SearchSectionCell.self) }
 //  // тип ячейки для обработки события
 //    var cellType: CatalogCellType { .categoryCell }
 //  // модель данных для отображения в ячейке
 //  var model: CatalogSectionModel?
 //
 //  // метод конфигурирования ячейки
 //  func setupCell(_ cell: UIView) {
 //    guard let cell = cell as? SearchSectionCellCellProtocol,
 //                let sectionModel = model else { return }
 //    // предположим, чтобы не вдаваться в детали, что в ячейке
 //    // имеется метод, который уже отоборажает все данные на ней.
 //    cell.displayData(sectionModel: sectionModel)
 //  }
 //
 // }
 //
 //// конфигуратор для ячеек с количеством валюты
 // final class QuantitiCurrencyConfigurator: Configurator {
 //
 //  // reuse id для таблицы который соответствует ячейке
 //    var reuseId: String { String(describing: SearchPreviousCell.self) }
 //  // тип ячейки для обработки события
 //    var cellType: CatalogCellType { .historyCell }
 //  // текст поискового запрос для отображения в ячейке
 //  var model: String?
 //
 //  // метод конфигурирования ячейки
 //  func setupCell(_ cell: UIView) {
 //    guard let cell = cell as? SearchPreviousCellProtocol,
 //                let searchModel = model else { return }
 //    // предположим, чтобы не вдаваться в детали, что в ячейке
 //    // имеется метод, который уже отоборажает все данные на ней.
 //    cell.displayData(searchModel: searchModel)
 //  }
 //
 // }

 // class Configurator: UITableViewCell {
 //
 //    override func awakeFromNib() {
 //        super.awakeFromNib()
 //        // Initialization code
 //    }
 //
 //    override func setSelected(_ selected: Bool, animated: Bool) {
 //        super.setSelected(selected, animated: animated)
 //
 //        // Configure the view for the selected state
 //    }
 //
 // }
 */
