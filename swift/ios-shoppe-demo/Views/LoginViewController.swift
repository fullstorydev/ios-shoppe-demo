//
//  LoginViewController.swift
//  ios-shoppe-demo
//
//  Created by Harold Davis Jr. on 5/24/20.
//  Copyright © 2020 Harold Davis Jr. All rights reserved.
//

import Foundation
import UIKit


class LoginTableViewController: UITableViewController {

    var userName: String = ""
    var emailAddress: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        user = UserProfile(addressDetail: [:])
    }

    func setupUI() {
        tableView.register(UINib(nibName: "ProductSummaryCell", bundle: nil), forCellReuseIdentifier: "thankYou")
        tableView.register(UINib(nibName: "CheckoutTableViewCell", bundle: nil), forCellReuseIdentifier: "textField")
    }

    // MARK: - TableViewDelegates
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "thankYou", for: indexPath) as? ThankYouCell
            cell?.thankYouLabel.text = "Login to the Shoppe"
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "textField", for: indexPath) as? CheckoutTableViewCell
            switch indexPath.row {
            case 1:
                cell?.addressDetailTextField.placeholder = "username"
            default:
                cell?.addressDetailTextField.placeholder = "email"
            }


            return cell ?? UITableViewCell()
        }

        return UITableViewCell()
    }

    func setUser(name: String, email: String) {
        user?.name = name
        user?.email = email

        fsIdentify(userInfo: user?.dictDescription() ?? [:])
    }

    func dismiss() {
        setUser(name: userName, email: emailAddress)
    }

}
