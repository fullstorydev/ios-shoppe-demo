//
//  ConfirmAddressTableViewCell.swift
//  ios-shoppe-demo
//
//  Created by Harold Davis Jr. on 4/17/20.
//  Copyright © 2020 Harold Davis Jr. All rights reserved.
//

import UIKit

class ConfirmAddressTableViewCell: UITableViewCell {
    @IBOutlet weak var detailLabel: UILabel!

    var userInfo: UserInfo! {
        didSet {
            setup()
        }
    }

    func setup() {
        detailLabel.text = userInfo.description()
    }
}
