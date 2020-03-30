//
//  AppStateController.swift
//  ios-shoppe-demo
//
//  Created by Harold Davis Jr. on 3/30/20.
//  Copyright © 2020 Harold Davis Jr. All rights reserved.
//

import Foundation
import UIKit

class AppStateController {
    static var sharedInstance = AppStateController()

    var user: String?
    var usernameTextField: UITextField?
    // TODO: var currentOrder: Order
    // TODO: func addToCart(product: Product)

    func displayAlert(view: UIViewController, completion: @escaping()->()) {
        let createUserAlert = UIAlertController(title: "Sign in to to start shoping.", message: nil, preferredStyle: .alert)
        createUserAlert.addTextField { (textField) in
            self.usernameTextField = textField
        }

        let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
            self.confirmUser()
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        createUserAlert.addAction(okAction)
        createUserAlert.addAction(cancelAction)

        view.present(createUserAlert, animated: true)
        completion()
    }

    func userField(textField: UITextField!) {
        usernameTextField = textField
    }

    func confirmUser() {
        if ((usernameTextField?.text) != nil) {
            user = usernameTextField?.text
        }
    }
}
