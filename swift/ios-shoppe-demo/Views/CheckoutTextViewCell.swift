//
//  CheckoutTextViewCell.swift
//  ios-shoppe-demo
//
//  Created on 4/10/20.
//  Copyright © 2020 FullStory All rights reserved.
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

    var cardDetail: CardDetail? {
        didSet {
            setup()
        }
    }

    func setup() {
        addressDetailTextField.placeholder = (addressDetail != nil) ? addressDetail?.placeHolder : cardDetail?.placeHolder
        addressDetailTextField.delegate = self
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        tableViewController?.tableView.reloadData()
    }
}
