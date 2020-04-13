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
    @IBOutlet weak var checkoutButton: UIButton!

    weak var tableViewController: CartTableViewController?

    func setupCartOrder() {
        guard let cartOrderTotal = tableViewController?.order.cartOrderTotal() else {
            return
        }

        checkoutButton.curveViewCornersWithShadow()
        orderTotalLabel.adjustsFontSizeToFitWidth = true
        orderTotalLabel.text = "$\(abs(cartOrderTotal.distance(to: 0)))"
    }

    @IBAction func proceedToCheckout(_ sender: Any) {
        let vc = CheckoutTableViewController()
        tableViewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
