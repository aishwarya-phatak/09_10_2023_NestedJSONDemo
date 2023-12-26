//
//  ProductDetailsViewController.swift
//  09_10_2023_NestedJSONDemo
//
//  Created by Vishal Jagtap on 26/12/23.
//

import UIKit

class ProductDetailsViewController: UIViewController {
    
    @IBOutlet weak var prRateLabel: UILabel!
    @IBOutlet weak var prCountLabel: UILabel!
    @IBOutlet weak var prPriceLabel: UILabel!
    var productContainer : Product?
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
    }
    
    func bindData(){
        self.prRateLabel.text = (productContainer?.rate.sign.rawValue.codingKey.stringValue)
        self.prCountLabel.text = (productContainer?.count.codingKey.stringValue)
        self.prPriceLabel.text = (productContainer?.price.description.codingKey.stringValue)
    }
}
