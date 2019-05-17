//
//  TransactionsViewController.swift
//  SwiftTechnicalTest
//
//  Created by GEORGE QUENTIN on 16/05/2019.
//  Copyright © 2019 GEORGE QUENTIN. All rights reserved.
//

import UIKit

private enum Constants {
    static let cellIdentifier = "TransactionCell"
}

class TransactionsViewController: UITableViewController {

    @IBAction func editButtonPressed(_ sender: UIBarButtonItem) {
        self.isEditing = !self.isEditing
    }
    
    var transactionVM = [TransactionData]()
    
    override func loadView() {
        super.loadView()
        title = "Transactions"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 1
        transactionVM = TransactionAPI.shared.sampleTransactionData()
        
    }

 
    override func encodeRestorableState(with coder: NSCoder) {
        super.encodeRestorableState(with: coder)
    }

    override func decodeRestorableState(with coder: NSCoder) {
        super.decodeRestorableState(with: coder)
    }

}

// MARK: - UITableViewDataSource
extension TransactionsViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactionVM.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell =
            tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as? TransactionsCell {
            if let transactionData = transactionVM.enumerated().first(where: { $0.offset == indexPath.row })?.element {
                cell.setTranscationdata(with: transactionData)
            }
        }
        return UITableViewCell()
    }
}

// MARK: - UITableViewDelegate
extension TransactionsViewController {
    override public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let transactionData = transactionVM.enumerated().first(where: { $0.offset == indexPath.row })?.element {
                delete(data: transactionData)
            }
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    //MARK: - update swipe model

    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let transactionData = transactionVM.enumerated().first(where: { $0.offset == indexPath.row })?.element {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}

// MARK- Manage TransactionData
extension TransactionsViewController {
    
    // MARK: - Selected Transaction
    func selected(data : TransactionData){
  
    }
    
    // MARK: - Update TodoItem in Realm DataBase
    func update(todoItem item: TransactionData) {
     
    }
    
    // MARK: - Update Transaction
    func delete(data item: TransactionData) {
       
    }

    // MARK: - Move a Transaction to index
    func move(data: TransactionData, to index: Int) {
      
    }

    // MARK: - Delete all Transactions
    func deleteAllTransactionData() {
        
    }

}



