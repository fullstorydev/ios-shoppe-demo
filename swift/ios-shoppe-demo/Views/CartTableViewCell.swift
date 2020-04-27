//
//  CartTableViewCell.swift
//  ios-shoppe-demo
//
//  Created on 4/7/20.
//  Copyright © 2020 FullStory All rights reserved.
//

import Foundation
import UIKit

class CartTableViewCell: UITableViewCell {
    @IBOutlet weak var orderTotalLabel: UILabel!

    weak var tableViewController: CartTableViewController?

    func setupCartOrder() {
        guard let cartOrderTotal = tableViewController?.order.cartOrderTotal() else {
            return
        }

        orderTotalLabel.adjustsFontSizeToFitWidth = true
        orderTotalLabel.text = "$\(abs(cartOrderTotal.distance(to: 0)))"
    }

    @IBAction func proceedToCheckout(_ sender: Any) {

    }
}
