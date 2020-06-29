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
            showTooltip()
        }
    }

    var cardDetail: CardDetail? {
        didSet {
            showTooltip()
        }
    }

    /**
     # showTooltip sets the placeholder text on the textfield based on the provided enum case's placeholder property.
     */
    func showTooltip() {
        if tableViewController?.autoFillEnabled ?? false { }
        else {
            addressDetailTextField.placeholder = (addressDetail != nil) ? addressDetail?.placeHolder : cardDetail?.placeHolder
        }

        addressDetailTextField.delegate = self
    }

    // MARK: - UITextFieldDelegate Methods

    func textFieldDidEndEditing(_ textField: UITextField) {
        if let addressDetail = addressDetail {
            tableViewController?.addressDict[addressDetail] = addressDetailTextField.text
        }

        tableViewController?.tableView.reloadData()
        textField.resignFirstResponder()
    }


    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
