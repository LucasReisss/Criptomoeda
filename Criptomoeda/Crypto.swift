//
//  Crypto.swift
//  Criptomoeda
//
//  Created by Lucas da Silva Reis on 12/12/21.
//

import Foundation

struct Crypto: Decodable{
    var asset_id: String?
    var name: String?
    var price_usd: Float?
    var id_icon: String?
    
    enum CodingKeys: String, CodingKey{
        case asset_id = "asset_id"
        case name = "name"
        case price_usd = "price_usd"
        case id_icon = "id_icon"
    }
}
