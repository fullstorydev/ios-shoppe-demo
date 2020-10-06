//
//  ProductViewCell.swift
//  ios-shoppe-demo
//
//  Created on 6/12/20.
//  Copyright © 2020 FullStory All rights reserved.
//

import UIKit

class ProductViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!

    var product: Product! {
        didSet {
            setup()
        }
    }

    func setup() {
        titleLabel.text = product.title
        quantityLabel.text = "x\(product.quantity)"
        totalLabel.text = getTotal(for: product).toCurrency()
    }
}
