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

    // TODO: - Add masking after FSManager is Approved. var fsManager = FullStoryManager.shared 

    func setupFSMaskingElements() {
        /*
         TODO: - Add masking after FSManager is Approved.
            fsManager.fsModify(status: .unmask, of: shippedLabel)
            fsManager.fsModify(status: .unmask, of: shippingLabel)
            fsManager.fsModify(status: .mask, of: nameLabel)
            fsManager.fsModify(status: .mask, of: shippingAddress)
         */
    }
}
