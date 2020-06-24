//
//  ProductViewCell.swift
//  ios-shoppe-demo
//
//  Created by Harold Davis Jr. on 6/12/20.
//  Copyright © 2020 Harold Davis Jr. All rights reserved.
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

    func setupMasking() {
        fsModifyPrivacy(setting: .unmask, of: titleLabel)
        fsModifyPrivacy(setting: .unmask, of: quantityLabel)
        fsModifyPrivacy(setting: .unmask, of: totalLabel)
    }
}
