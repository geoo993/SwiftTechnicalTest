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
    static let transactionDataRestorationKey = "transactionData"
}

class TransactionsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBAction func editButtonPressed(_ sender: UIBarButtonItem) {
        tableView.allowsSelection = !tableView.allowsSelection
        selection(enabled: tableView.allowsSelection)
    }
    
    private var removeButtonInitialHeight: CGFloat = 60
    @IBOutlet weak var removeButton: UIButton!
    @IBOutlet weak var removeButtonHeightConstraint: NSLayoutConstraint!
    @IBAction func removeSelectedRows(_ sender: UIButton) {
        removeCells()
    }

    var transactionVM = [TransactionData]()
    override func loadView() {
        super.loadView()
        removeButtonInitialHeight = removeButtonHeightConstraint.constant
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1 - navigation bar
        self.navigationController?.title = "Transactions"
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)
        ]
        
        // 2- disable selection of tableview
        tableView.allowsSelection = false
        
        // 3- fetch transaction data
        //transactionVM = TransactionAPI.shared.sampleTransactionData()
        TransactionAPI.shared.fetchTransactionData { [weak self] transactionData in
            guard let this = self else { return }
            this.transactionVM = transactionData
            this.tableView.reloadData()
        }
        
       
        // 4- update selected
        selection(enabled: tableView.allowsSelection)
    }

    override func encodeRestorableState(with coder: NSCoder) {
        super.encodeRestorableState(with: coder)
    }

    override func decodeRestorableState(with coder: NSCoder) {
        super.decodeRestorableState(with: coder)
    }

}

// MARK: - UITableViewDataSource
extension TransactionsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactionVM.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell =
            tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as? TransactionsCell {
            if let transactionData = transactionVM.enumerated().first(where: { $0.offset == indexPath.row })?.element {
                cell.setTranscationdata(with: transactionData)
                //print(transactionData.summary)
            }
            return cell
        }
        return UITableViewCell()
    }
}

// MARK: - UITableViewDelegate
extension TransactionsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //if let transactionData = transactionVM.enumerated().first(where: { $0.offset == indexPath.row })?.element {
            //print(indexPath.row)
        //}
    }
}

// MARK- Manage TransactionData
extension TransactionsViewController {
    
    // MARK: - Allow selection of tableview cells
    func selection(enabled: Bool){
        editButton.title = enabled ? "Done" : "Edit"
        tableView.allowsMultipleSelection = enabled
        tableView.allowsMultipleSelectionDuringEditing = enabled
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        if enabled {
            if let app = UIApplication.shared.delegate as? AppDelegate,
                let window = app.window {
                removeButtonHeightConstraint.constant =
                    removeButtonInitialHeight + window.safeAreaInsets.bottom
            } else {
                removeButtonHeightConstraint.constant = removeButtonInitialHeight
            }
        } else {
            removeButtonHeightConstraint.constant = 0
            deselectCells()
        }
    }
    
    // MARK: - Uncheck the selected Transaction cells
    func deselectCells() {
        if let selectedIndexPaths = tableView.indexPathsForSelectedRows {
            for indexPath in selectedIndexPaths {
                tableView.deselectRow(at: indexPath, animated: true)
            }
        }
    }
    
    // MARK: - Delete the selected Transaction cells
    func removeCells() {
        if let selectedIndexPaths = tableView.indexPathsForSelectedRows {
            let indexes = selectedIndexPaths.map{ $0.row }
            let filteredTransactions = transactionVM.enumerated().filter({ !indexes.contains($0.offset) }).map({ $0.element })
            transactionVM = filteredTransactions
        }
        tableView.reloadData()
    }
}



