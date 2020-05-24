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

    func showTooltip() {
        if tableViewController?.autoFillEnabled ?? false { }
        else {
            addressDetailTextField.placeholder = (addressDetail != nil) ? addressDetail?.placeHolder : cardDetail?.placeHolder
        }
        addressDetailTextField.delegate = self
    }

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

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
}
