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

    var tableViewController: CartTableViewController?

    func setupCartOrder() {
        guard let cartOrderTotal = tableViewController?.order.cartOrderTotal() else {
            return
        }

        orderTotalLabel.text = "$\(cartOrderTotal)"
    }

    @IBAction func proceedToCheckout(_ sender: Any) {

    }
}
