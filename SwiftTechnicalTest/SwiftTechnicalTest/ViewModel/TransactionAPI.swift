//
//  TransactionAPI.swift
//  SwiftTechnicalTest
//
//  Created by GEORGE QUENTIN on 16/05/2019.
//  Copyright © 2019 GEORGE QUENTIN. All rights reserved.
//

import UIKit

extension Notification.Name {
    static let downloadImageNotification = Notification.Name("DownloadImageNotification")
}

final class TransactionAPI {
    
    static let shared = TransactionAPI()
    private let persistencyManager = PersistencyManager()
    private init() {
        // Get data of transactions
        NotificationCenter.default
            .addObserver(self, selector: #selector(downloadTransactionData(with:)), name: .downloadImageNotification, object: nil)
    }
    
    // MARK: - mock transaction Data
    func sampleTransactionData() -> [TransactionData] {
        return [
            TransactionData(data: ["id": "01", "description": "Paying Bill",
                                   "category": "Rent", "currency": Currency.gbp, "value": 430.50,
                                   "title": "Santander", "icon": "santander"]),
            TransactionData(data: ["id": "02", "description": "Loaning money to Aaron",
                                   "category": "Loan", "currency": Currency.gbp, "value": 30.02,
                                   "title": "Santander", "icon": "santander"])
        ]
    }
    
    // MARK: - Networking to fetch Transaction data
    func fetchTransactionData(with completion: @escaping ([TransactionData]) -> () ) {
        guard let url = URL(string: "https://www.mocky.io/v2/5b36325b340000f60cf88903") else { return }
        URLSession.shared.dataTask(with: url) { [weak self] (dataresult, response, error) in
            guard let this = self else { return }
            if error != nil {
                return
            }
            do {
                guard let data = dataresult,
                    let jsonData = try JSONSerialization
                    .jsonObject(with: data, options: .mutableContainers) as? [String: AnyObject] else {
                        return
                }
                //print(jsonData)
                
                var transactions = [TransactionData]()
                
                for dict in jsonData["data"] as! [[String: AnyObject]] {
                    var data = [String: Any]()
                    data["id"] = dict["id"] as! String
                    data["description"] = dict["description"] as! String
                    data["category"] = dict["category"] as! String
                    if let currency = dict["currency"] as? String {
                        data["currency"] = Currency(rawValue: currency)
                    }
                    if let amount = dict["amount"] as? [String: AnyObject] {
                        data["value"] = amount["value"] as! Double
                    }
                    if let product = dict["product"] as? [String: AnyObject] {
                        data["title"] = product["title"] as! String
                        data["icon"] = product["icon"] as! String
                    }
                    //print(data)
                    transactions.append(TransactionData(data: data))
                }
                this.persistencyManager.saveTransactionData(with: data)
                
                DispatchQueue.main.async(execute: { () -> Void in
                    completion(transactions)
                })
            } catch let err {
                fatalError("Could not fetch Transaction Data with URL: \(err)")
            }
        }.resume()
        
    }
    
    // MARK: - Cache and load bank images
    @objc func downloadTransactionData(with notification: Notification) {
        guard let userInfo = notification.userInfo,
            let imageView = userInfo["imageView"] as? UIImageView,
            let imageUrl = userInfo["imageUrl"] as? String,
            let filename = URL(string: imageUrl)?.lastPathComponent else {
                return
        }
        if let savedImage = persistencyManager.getImage(with: filename) {
            imageView.image = savedImage
            return
        }
        DispatchQueue.global().async { [weak self] () -> Void in
            guard let this = self else { return }
            let downloadedImage = this.persistencyManager.downloadImage(imageUrl) ?? UIImage()
            DispatchQueue.main.async {
                imageView.image = downloadedImage
                this.persistencyManager.saveImage(downloadedImage, filename: filename)
            }
        }
    }
}
