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

    func setupFSMaskingElements() {
        // MARK: - FullStory masking Example
        fsModifyPrivacy(setting: .mask, views: [nameLabel, shippingAddress])
    }
}
