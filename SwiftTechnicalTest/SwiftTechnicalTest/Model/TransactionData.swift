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
    let imageURL : String
}

struct TransactionData: Codable {
    let id: String
    let description : String
    let category: String
    let currency : Currency
    let value : Double
    let bank : Bank
}

extension TransactionData: CustomStringConvertible {
    var summary: String {
        return
            " title: \(id)" +
            " description: \(description)" +
            " category: \(category)" +
            " currency: \(currency.rawValue)" +
            " value: \(value)" +
            " bank: \(bank.title)" +
            " imageUrl: \(bank.imageURL)"
    }
}
