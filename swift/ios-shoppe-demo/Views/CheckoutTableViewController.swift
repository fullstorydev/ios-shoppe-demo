//
//  CheckoutTableViewController.swift
//  ios-shoppe-demo
//
//  Created by Harold Davis Jr. on 4/10/20.
//  Copyright © 2020 Harold Davis Jr. All rights reserved.
//

import UIKit

class CheckoutTableViewController: UITableViewController {
    
    var cellItems: [AddressDetail] = [.name, .street, .unit, .city, .state, .zip, .phone]

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "CheckoutTableView", bundle: nil), forCellReuseIdentifier: "textField")
        tableView.register(UINib(nibName: "CheckoutTableView", bundle: nil), forCellReuseIdentifier: "title")
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return cellItems.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "title", for: indexPath)

            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "textField", for: indexPath) as? CheckoutTableViewCell

            return cell ?? UITableViewCell()
        }
    }
}
