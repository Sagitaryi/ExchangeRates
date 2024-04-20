import UIKit

class ViewController: UIViewController {
    let networkClient = NetworkClient()

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func getAllCurrenciesButtonPressed(_ sender: UIButton) {
        let symbolsService = SymbolsService(networkClient: networkClient)
        symbolsService.fetchSymbols { result in
            switch result {
            case .success(let data):
                print(data)
            case .failure(let error):
                print(error)
            }
        }
        print("end")
    }


    @IBAction func getExchangeRateButtonPressed(_ sender: UIButton) {
        let ratesService = RatesService(networkClient: networkClient)
        ratesService.fetchRates(base: "EUR", symbols: ["USD", "RUB", "PHP", "PAB"]) { result in
            switch result {
            case .success(let model):
                print(model)
            case .failure(let error):
                print(error)
            }
        }

    }
    




}
