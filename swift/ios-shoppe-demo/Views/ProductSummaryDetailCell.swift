//
//  ProductSummaryDetailCell.swift
//  ios-shoppe-demo
//
//  Created on 5/8/20.
//  Copyright © 2020 FullStory All rights reserved.
//

import Foundation
import UIKit

class ProductSummaryDetailCell: UITableViewCell {
    @IBOutlet weak var shippedLabel: UILabel!
    @IBOutlet weak var shippingLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var shippingAddress: UILabel!

    /// This is an example of how to unmask items we may want to show, in order to help someone follow the recorded flow easier.
    func setupFSMaskingElements() {
        fsModify(status: .unmask, of: shippedLabel)
        fsModify(status: .unmask, of: shippingLabel)
    }
}
