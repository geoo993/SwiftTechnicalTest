//
//  TransactionAPI.swift
//  SwiftTechnicalTest
//
//  Created by GEORGE QUENTIN on 16/05/2019.
//  Copyright © 2019 GEORGE QUENTIN. All rights reserved.
//

import Foundation

extension Notification.Name {
    static let downloadImageNotification = Notification.Name("DownloadImageNotification")
}

final class TransactionAPI {
    
    static let shared = TransactionAPI()
    
    private init() {
        
//        // Get data of transactions
//        NotificationCenter.default
//            .addObserver(self, selector: #selector(downloadTransactionData(with:)), name: .downloadImageNotification, object: nil)
    }
    
    
    // MARK: - mockt ransaction Data
    func sampleTransactionData() -> [TransactionData] {
        return [
            TransactionData(id: "01", description: "Paying Bill",
                            category: "Rent", currency: .gbp, value: 430.50,
                            bank: Bank(title: "Santander", imageURL: "santander")),
            TransactionData(id: "02", description: "Loaning money to Aaron",
                            category: "Loan", currency: .gbp, value: 30.02,
                            bank: Bank(title: "Santander", imageURL: "santander"))
        
        ]
    }
    
    // MARK: - Read from TodoItem Realm DataBase
    func fetchTransactionData() {
        let urlString = "http://www.mocky.io/v2/5b36325b340000f60cf88903"
        URLSession.shared.dataTask(with: URL(string: urlString)!) { (data, response, error) in
            if error != nil {
                
            }
            print(data, response, error)
            do {
                let json =
                    try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)

                print(json)
            } catch let err {
                fatalError("Could not fetch Transaction Data with URL: \(err)")
            }
        }.resume()
        
    }

    
}
