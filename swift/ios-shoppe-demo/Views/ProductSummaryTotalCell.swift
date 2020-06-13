//
//  ProductSummaryTotalCell.swift
//  ios-shoppe-demo
//
//  Created on 5/6/20.
//  Copyright © 2020 FullStory All rights reserved.
//

import Foundation
import UIKit


class ProductSummaryTotalCell: UITableViewCell {
    @IBOutlet weak var totalLabel: UILabel!

    var order: Order! {
        didSet {
            setup()
        }
    }

    func setup() {
        DispatchQueue.main.async {
            self.totalLabel.text = self.order.cartOrderTotal.toCurrency()
        }
    }
}
