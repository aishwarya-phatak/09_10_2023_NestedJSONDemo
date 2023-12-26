//
//  ProductTableViewCell.swift
//  09_10_2023_NestedJSONDemo
//
//  Created by Vishal Jagtap on 26/12/23.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var prIdLabel: UILabel!
    @IBOutlet weak var prRateLabel: UILabel!
    @IBOutlet weak var prCountLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
