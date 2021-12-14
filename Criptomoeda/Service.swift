//
//  Service.swift
//  Criptomoeda
//
//  Created by Lucas da Silva Reis on 12/12/21.
//

import Foundation
import Alamofire

class Service {
    fileprivate var baseUrl = ""
    typealias cryptocurrenciesCallback = ([Crypto]?, Bool, _ message: String) -> Void
    var callBack: cryptocurrenciesCallback?
    
    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    
    func getAllCryptoNameFrom(endPoint:String){
        AF.request(self.baseUrl + endPoint, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response {
            (responseData) in
            guard let data = responseData.data else {
                self.callBack?(nil, false, "")
                return}
            do{
            let cryptocurrencies = try JSONDecoder().decode([Crypto].self, from: data)
                self.callBack?(cryptocurrencies, true, "")
            }catch{
                self.callBack?(nil, false, error.localizedDescription)
            }
        }
    }
    
    func competionHandler(callBack: @escaping cryptocurrenciesCallback){
        self.callBack = callBack
    }
}
