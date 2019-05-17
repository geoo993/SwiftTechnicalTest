//
//  TransactionData.swift
//  SwiftTechnicalTest
//
//  Created by GEORGE QUENTIN on 16/05/2019.
//  Copyright © 2019 GEORGE QUENTIN. All rights reserved.
//

import Foundation

enum Currency: String, Codable {
    case gbp = "GBP"
    case euro = "EURO"
    case usd = "USD"
}
extension Currency {
    var toSymbol: String {
        switch self {
        case .gbp: return "£"
        case .euro: return "€"
        case .usd: return "$"
        }
    }
}
struct Bank: Codable {
    let title : String
    let imageUrl : String
}
struct TransactionData: Codable {
    let id: String
    let description : String
    let category: String
    let currency : Currency
    let value : Double
    let bank : Bank
    init(data: [String: Any]) {
        self.id = data["id"] as! String
        self.description = data["description"] as! String
        self.category = data["category"] as! String
        self.currency = data["currency"] as! Currency
        self.value = data["value"] as! Double
        let bankTitle = data["title"] as! String
        let bankImageUrl = data["icon"] as! String
        self.bank = Bank(title: bankTitle, imageUrl: bankImageUrl)
    }
}
extension TransactionData: CustomStringConvertible {
    var summary: String {
        return
            " id: \(id)\n" +
            " description: \(description)\n" +
            " category: \(category)\n" +
            " currency: \(currency.rawValue)\n" +
            " value: \(value.toCurrency)\n" +
            " bank title: \(bank.title)\n" +
            " imageUrl: \(bank.imageUrl)\n"
    }
}
