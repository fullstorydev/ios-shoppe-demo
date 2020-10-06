//
//  ProductSummaryView.swift
//  ios-shoppe-demo
//
//  Created on 4/30/20.
//  Copyright © 2020 FullStory All rights reserved.
//

import Foundation
import UIKit

class ProductSummaryView: UITableViewController {
    var checkoutTableViewController: CheckoutTableViewController!
    var purchasedItems: [Product] {
        return order.getFilteredItems()
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "ProductSummaryCell", bundle: nil), forCellReuseIdentifier: "quantity")
        tableView.register(UINib(nibName: "ProductSummaryTopCell", bundle: nil), forCellReuseIdentifier: "thankYou")
        tableView.register(UINib(nibName: "ProductSummaryUserDetailCell", bundle: nil), forCellReuseIdentifier: "userDetails")
        tableView.register(UINib(nibName: "ProductSummaryTotalCost", bundle: nil), forCellReuseIdentifier: "totalCell")
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor().fsBackground()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        order.resetOrder()
        checkoutTableViewController.navigationController?.popToRootViewController(animated: true)
    }

    @objc func dismissBacktoRoot() {
        checkoutTableViewController.navigationController?.popToRootViewController(animated: true)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0, 1, 3:
            return 1
        case 2:
            return purchasedItems.count
        default:
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "thankYou", for: indexPath) as? ThankYouCell
            return cell ?? UITableViewCell()
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "userDetails", for: indexPath) as? ProductSummaryDetailCell

            return cell ?? UITableViewCell()
        case 2:
            let product = purchasedItems[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "quantity", for: indexPath) as? ProductSummaryCell

            cell?.product = product

            return cell ?? UITableViewCell()
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "totalCell", for: indexPath) as? ProductSummaryTotalCell

            cell?.order = order

            return cell ?? UITableViewCell()
        default:
            return UITableViewCell()
        }
    }
}
