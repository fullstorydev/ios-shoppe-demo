//
//  LoginButtonTableViewCell.swift
//  ios-shoppe-demo
//
//  Created on 8/19/20.
//  Copyright © 2020 FullStory All rights reserved.
//


import UIKit

class LoginButtonTableViewCell: UITableViewCell {

    var loginViewController: LoginCollectionViewController?

    @IBAction func login(_ sender: Any) {
        loginViewController?.login()
    }
}
