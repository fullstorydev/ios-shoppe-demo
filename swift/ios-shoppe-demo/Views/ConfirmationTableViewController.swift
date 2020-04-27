//
//  ConfirmationTableViewController.swift
//  ios-shoppe-demo
//
//  Created on 4/17/20.
//  Copyright © 2020 by FullStory All rights reserved.
//

import UIKit

class ConfirmationTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "CheckoutTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")

    }
}
