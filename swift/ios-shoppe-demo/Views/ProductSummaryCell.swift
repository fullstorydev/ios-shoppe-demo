//
//  ProductSummaryCell.swift
//  ios-shoppe-demo
//
//  Created on 4/30/20.
//  Copyright © 2020 FullStory All rights reserved.
//

import Foundation
import UIKit


class ProductSummaryCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!

    var product: Product! {
        didSet {
            setup()
        }
    }

    func setup() {
        DispatchQueue.main.async {
            self.titleLabel.text = self.product.title
            self.quantityLabel.text = "x\(self.product.quantity)"
            self.totalLabel.text = "$\(self.product.getTotal())"
        }
    }
}
