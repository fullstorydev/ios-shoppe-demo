//
//  CheckBoxButtonCell.swift
//  ios-shoppe-demo
//
//  Created on 5/28/20.
//  Copyright © 2020 FullStory All rights reserved.
//

import Foundation
import UIKit

class CheckBoxButtonCell: UITableViewCell {
    @IBOutlet weak var checkboxButton: UIButton!
    var boxIsChecked: Bool = false
    var checkoutView: CheckoutTableViewController?

    @IBAction func checkbox(_ sender: Any) {
        boxIsChecked = !boxIsChecked ? true : false

        DispatchQueue.main.async {
            if let checkoutView = self.checkoutView {
                self.checkboxButton.backgroundColor = self.boxIsChecked ? #colorLiteral(red: 0.8588374853, green: 0.3019890189, blue: 0.564645946, alpha: 1) : .white

                checkoutView.pageCanGoForward = self.boxIsChecked
                checkoutView.tableView.reloadData()
            }
        }

    }
}

