//
//  TransactionsCell.swift
//  SwiftTechnicalTest
//
//  Created by GEORGE QUENTIN on 16/05/2019.
//  Copyright © 2019 GEORGE QUENTIN. All rights reserved.
//

import UIKit

@IBDesignable
class TransactionsCell: UITableViewCell {

    @IBInspectable var selectedColor: UIColor = UIColor.lightGray
    @IBInspectable var hightlightedColor: UIColor = UIColor.darkGray
    
    @IBOutlet weak var bankImageView: UIImageView!
    @IBOutlet weak var bankImageContainer: UIView!
    @IBOutlet weak var transactionDescriptionLabel: UILabel!
    @IBOutlet weak var transactionCategoryLabel: UILabel!
    @IBOutlet weak var transactionValueLabel: UILabel!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.backgroundColor = selected ? selectedColor : .clear
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        self.backgroundColor = highlighted ? hightlightedColor : .clear
    }

    func setTranscationdata(with data: TransactionData) {
        transactionDescriptionLabel.text = data.description
        transactionCategoryLabel.text = data.category
        transactionValueLabel.text = data.currency.toSymbol + data.value.toCurrency
        bankImageContainer.layer.cornerRadius = bankImageContainer.frame.height / 2
        bankImageView.layer.cornerRadius = bankImageView.frame.height / 2
        //bankImageView.image = UIImage(named: data.bank.imageURL)
        NotificationCenter.default
            .post(name: .downloadImageNotification, object: self,
                  userInfo: ["imageView": bankImageView as Any, "imageUrl" : data.bank.imageUrl])
    }
}
