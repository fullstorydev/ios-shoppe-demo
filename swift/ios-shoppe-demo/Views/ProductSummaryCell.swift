//
//  ProductSummaryCell.swift
//  ios-shoppe-demo
//
//  Created on 4/30/20.
//  Copyright © 2020 Harold Davis Jr. All rights reserved.
//

import Foundation
import UIKit


class ProductSummaryCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!

    var product: Product! {
        didSet {
            setup()
        }
    }

    func setup() {
        DispatchQueue.main.async {
            self.titleLabel.text = self.product.title
            self.quantityLabel.text = "\(self.product.quantity)"
        }
    }
}
