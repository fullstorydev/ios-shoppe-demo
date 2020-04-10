//
//  File.swift
//  ios-shoppe-demo
//
//  Created by Harold Davis Jr. on 4/9/20.
//  Copyright © 2020 Harold Davis Jr. All rights reserved.
//

import Foundation
import UIKit

class CartQuantityTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!

    var product: Product! {
        didSet {
            setup()
        }
    }

    weak var tableViewController: CartTableViewController?

    func setup() {
        guard let product = product else {
            tableViewController?.tableView.reloadData()
            return
        }

        titleLabel.text = product.title
        quantityLabel.text = "\(product.quantity)"
    }

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
            tableViewController?.tableView.reloadData()
        }
    }
}
