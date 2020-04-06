//
//  CartTableViewCell.swift
//  ios-shoppe-demo
//
//  Created by Harold Davis Jr. on 4/3/20.
//  Copyright © 2020 Harold Davis Jr. All rights reserved.
//

import Foundation
import UIKit

class CartTableViewCell: UITableViewCell {
    @IBOutlet weak var orderTotalLabel: UILabel!

    var tableViewController: CartTableViewController?

    func setupCartOrder() {
        orderTotalLabel.text = "$\(OrderManager.sharedInstance.cartOrderTotal())"
    }

    @IBAction func proceedToCheckout(_ sender: Any) {
        
    }
}
