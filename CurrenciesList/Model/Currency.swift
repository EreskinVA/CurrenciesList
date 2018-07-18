//
//  Currency.swift
//  CurrenciesList
//
//  Created by Vladimir Ereskin on 18.07.2018.
//  Copyright © 2018 Vladimir Ereskin. All rights reserved.
//

import Foundation

struct Price: Decodable {
    var currency: String
    var amount: Double
}

struct CurrencyStruct: Decodable {
    var name: String
    var price: Price
    var percent_change: Double
    var volume: Int
    var symbol: String
}

struct Currency: Decodable {
    var stock: [CurrencyStruct]
}
