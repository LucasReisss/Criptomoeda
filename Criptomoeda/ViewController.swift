//
//  ViewController.swift
//  Criptomoeda
//
//  Created by Lucas da Silva Reis on 12/12/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tblCryptocurrencies: UITableView!
    var cryptocurrencies = [Crypto]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblCryptocurrencies.dataSource = self
        // Do any additional setup after loading the view.
        let service = Service(baseUrl: "https://rest.coinapi.io/")
        service.getAllCryptoNameFrom(endPoint: "v1/assets/?apikey=D851B169-E22C-4741-998A-D9B92C86A487")
        service.competionHandler { [weak self] (cryptocurrencies, status, message) in
            if status{
                guard let self = self else {return}
                guard let _cryptocurrencies = cryptocurrencies else {return}
                self.cryptocurrencies = _cryptocurrencies
                self.tblCryptocurrencies.reloadData()
            }
        }
    }


}

extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cryptocurrencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cryptocell", for: indexPath) as! CryptoTableViewCell
        
        let crypto = cryptocurrencies[indexPath.row]
        let dolar = crypto.price_usd ?? 0
        let real = "\(dolar * 5.50)"
        
        cell.assedIdLabel.text = crypto.asset_id ?? ""
        cell.nameLabel.text = crypto.name ?? ""
        cell.priceUsdLabel.text = "$\(crypto.price_usd ?? 0)"
        cell.priceRealLabel.text = "R$\(real)"
        
        
        /*let url = URL(string: crypto.id_icon!)

        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                cell.iconImage.image = UIImage(data: data!)
            }
        }*/

        return cell
    }
    
}

