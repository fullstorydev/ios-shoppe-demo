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

    weak var cartTableViewController: CartTableViewController?
    weak var checkoutTableViewController: CheckoutTableViewController?

    func setup() {
        setupCartOrder()

        checkoutButton.curveViewCornersWithShadow()
        checkoutButton.titleLabel?.text = "Place your order"
    }

    func setupCartOrder() {

        checkoutButton.curveViewCornersWithShadow()
        orderTotalLabel.adjustsFontSizeToFitWidth = true
        orderTotalLabel.text = "$\(abs(order.cartOrderTotal().distance(to: 0)))"
    }

    @IBAction func proceedToCheckout(_ sender: Any) {

        if cartTableViewController != nil {
            cartTableViewController?.presentCheckout()
            }
        else {

        }
    }
}
