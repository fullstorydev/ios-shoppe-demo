//
//  CheckoutTableViewController.swift
//  ios-shoppe-demo
//
//  Created on 4/10/20.
//  Copyright © 2020 FullStory All rights reserved.
//

import UIKit

class CheckoutTableViewController: UITableViewController {
    
    var addressItems: [AddressDetail] = [.name, .street, .unit, .city, .state, .zip, .phone]
    var cardItems: [CardDetail] = [.name, .cardNumber, .expiration, .csv]

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Complete Order"
        tableView.register(UINib(nibName: "CheckoutTableViewCell", bundle: nil), forCellReuseIdentifier: "textField")
        tableView.register(UINib(nibName: "LargeLabelTableViewCell", bundle: nil), forCellReuseIdentifier: "title")
        tableView.register(UINib(nibName: "CartTableViewCell", bundle: nil), forCellReuseIdentifier: "checkout")
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0, 2, 4:
            return 1
        case 1:
            return addressItems.count
        case 3:
            return cardItems.count
        default:
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "title", for: indexPath) as? LargeLabelTableViewCell
            return cell ?? UITableViewCell()
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "textField", for: indexPath) as? CheckoutTableViewCell
            cell?.addressDetail = addressItems[indexPath.row]

            return cell ?? UITableViewCell()
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "title", for: indexPath) as? LargeLabelTableViewCell
            cell?.largeTextLabel.text = "Payment Info"

            return cell ?? UITableViewCell()
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "textField", for: indexPath) as? CheckoutTableViewCell
            cell?.cardDetail = cardItems[indexPath.row]

            return cell ?? UITableViewCell()
        case 4:
            let cell =  tableView.dequeueReusableCell(withIdentifier: "checkout") as? CartTableViewCell

            cell?.checkoutTableViewController = self
            
            DispatchQueue.main.async {
                cell?.setup()
            }
            
            return cell ?? UITableViewCell()
        default:
            return UITableViewCell()
        }
    }
}
