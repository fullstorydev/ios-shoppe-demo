//
//  File.swift
//  ios-shoppe-demo
//
//  Created on 4/9/20.
//  Copyright © 2020 FullStory All rights reserved.
//

import Foundation
import UIKit

class CartQuantityTableViewCell: ProductViewCell {
    weak var tableViewController: CartTableViewController?

    @IBAction func addQuantity(_ sender: Any) {
        product?.quantity += 1
        tableViewController?.setOrderItemsForCart()
        tableViewController?.tableView.reloadData()
    }

    @IBAction func subtractQuantity(_ sender: Any) {
        guard let product = product else {
            tableViewController?.setOrderItemsForCart()
            tableViewController?.tableView.reloadData()
            return
        }

        product.quantity -= 1

        if product.quantity <= 0 {
            tableViewController?.setOrderItemsForCart()
        }

        tableViewController?.tableView.reloadData()
    }
}
