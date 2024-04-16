import UIKit

class ViewController: UIViewController {
let networkClient = NetworkClient()

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func ReturnsAllCurrencies(_ sender: UIButton) {
        print("Begin")
        let service = SymbolsService(networkClient: networkClient)
        service.fetchSymbols { result in
            switch result {
            case .success(let data):
                print("OK")
                print(data)
            case .failure(let error):
                print(error)
            }
        }
        print("end")

        }





}
