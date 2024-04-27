import UIKit

class ViewController: UIViewController {
    let networkClient = NetworkClient()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func getAllCurrenciesButtonPressed(_: UIButton) {
        let symbolsService = SymbolsService(networkClient: networkClient)
        symbolsService.fetchSymbols { result in
            switch result {
            case let .success(data):
                print(data)
            case let .failure(error):
                print(error)
            }
        }
        print("end")
    }

    @IBAction func getExchangeRateButtonPressed(_: UIButton) {
        let ratesService = RatesService(networkClient: networkClient)
        ratesService.fetchRates(base: "EUR", symbols: ["USD", "RUB", "PHP", "PAB"]) { result in
            switch result {
            case let .success(model):
                print(model)
            case let .failure(error):
                print(error)
            }
        }
    }
}
