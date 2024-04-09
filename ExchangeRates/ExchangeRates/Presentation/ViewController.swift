import UIKit

class ViewController: UIViewController {
let networkClient = NetworkClient()

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func ReturnsAllCurrencies(_ sender: UIButton) {
//        let symbols = SymbolsModel(response: <#T##SymbolsResponseDTO#>)
//        let objectSymbolsService = SymbolsService(networkClient: networkClient)
//        objectSymbolsService.fetchSymbols(completion: <#T##(Result<SymbolsModel, NetworkClientError>) -> ()#>)

let objectSymbolsService = SymbolsService(networkClient: networkClient)
        objectSymbolsService.fetchSymbols { result in
            print(result)
        }
        }





}
