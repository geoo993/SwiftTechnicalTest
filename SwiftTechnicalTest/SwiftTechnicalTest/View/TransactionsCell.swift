//
//  TransactionsCell.swift
//  SwiftTechnicalTest
//
//  Created by GEORGE QUENTIN on 16/05/2019.
//  Copyright © 2019 GEORGE QUENTIN. All rights reserved.
//

import UIKit

class TransactionsCell: UITableViewCell {

    @IBOutlet weak var bankImageView: UIImageView!
    @IBOutlet weak var transactionDescriptionLabel: UILabel!
    @IBOutlet weak var transactionCategoryLabel: UILabel!
    @IBOutlet weak var transactionValueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setTranscationdata(with data: TransactionData) {
        bankImageView.image = UIImage(named: data.bank.imageURL)
        transactionDescriptionLabel.text = data.description
        transactionCategoryLabel.text = data.category
        transactionValueLabel.text = data.currency.toSymbol + data.value.toString
        bankImageView.layer.cornerRadius = bankImageView.frame.height / 2
    }

}
