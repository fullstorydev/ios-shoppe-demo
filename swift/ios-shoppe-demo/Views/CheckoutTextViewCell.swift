//
//  CheckoutTextViewCell.swift
//  ios-shoppe-demo
//
//  Created by Harold Davis Jr. on 4/10/20.
//  Copyright © 2020 Harold Davis Jr. All rights reserved.
//

import Foundation
import UIKit

class CheckoutTableViewCell: UITableViewCell, UITextFieldDelegate {
    @IBOutlet weak var addressDetailTextField: UITextField!

    var tableViewController: CheckoutTableViewController?
    var addressDetail: AddressDetail? {
        didSet {
            setup()
        }
    }

    func setup() {
        guard addressDetail != nil else {
            return
        }

        addressDetailTextField.delegate = self
        addressDetailTextField.placeholder = addressDetail?.placeHolder
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        tableViewController?.tableView.reloadData()
    }
}
