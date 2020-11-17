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

    var checkoutTableViewController: CheckoutTableViewController?
    var loginTableViewController: LoginCollectionViewController?

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
        if !(checkoutTableViewController?.autoFillEnabled ?? false) { 
            addressDetailTextField.placeholder = (addressDetail != nil) ? addressDetail?.placeHolder : cardDetail?.placeHolder
        }

        addressDetailTextField.delegate = self
    }

    func setPlaceholder(_ name: String) {
        addressDetailTextField.placeholder = name
    }

    // MARK: - UITextFieldDelegate Methods

    func textFieldDidEndEditing(_ textField: UITextField) {
        if let addressDetail = addressDetail {
            checkoutTableViewController?.addressDict[addressDetail] = addressDetailTextField.text
            checkoutTableViewController?.tableView.reloadData()
        } else {
            loginTableViewController?.tableView.reloadData()

        }

        textField.resignFirstResponder()
    }


    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
