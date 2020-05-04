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
    @IBOutlet var checkoutButton: UIButton!

    weak var cartTableViewController: CartTableViewController?
    weak var checkoutTableViewController: CheckoutTableViewController? {
        didSet {
            DispatchQueue.main.async {
                self.setTextForPlacingOrder()
            }
        }
    }

    func setup() {
        checkoutButton.curveViewCornersWithShadow()
        orderTotalLabel.adjustsFontSizeToFitWidth = true
        orderTotalLabel.text = "$\(abs(order.cartOrderTotal().distance(to: 0)))"
    }

    func setTextForPlacingOrder() {
        self.checkoutButton.titleLabel?.text = "Place your order"
    }

    @IBAction func proceedToCheckout(_ sender: Any) {
        if cartTableViewController != nil {
            cartTableViewController?.presentCheckout()
        }
    }
}
