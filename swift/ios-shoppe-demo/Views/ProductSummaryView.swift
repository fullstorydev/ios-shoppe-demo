//
//  ProductSummaryView.swift
//  ios-shoppe-demo
//
//  Created on 4/30/20.
//  Copyright © 2020 FullStory All rights reserved.
//

import Foundation
import UIKit

let fsBackgroundColor: UIColor = #colorLiteral(red: 0.03917218745, green: 0.1215802506, blue: 0.196048826, alpha: 1)

class ProductSummaryView: UITableViewController {
    var checkoutTableViewController: CheckoutTableViewController!
    var purchasedItems: [Product] {
        return order.items.filter { return $0.quantity > 0 }
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "ProductSummaryCell", bundle: nil), forCellReuseIdentifier: "quantity")
        tableView.register(UINib(nibName: "ProductSummaryTopCell", bundle: nil), forCellReuseIdentifier: "thankYou")
        tableView.register(UINib(nibName: "ProductSummaryUserDetailCell", bundle: nil), forCellReuseIdentifier: "userDetails")
        tableView.register(UINib(nibName: "ProductSummaryTotalCost", bundle: nil), forCellReuseIdentifier: "totalCell")
        tableView.separatorStyle = .none
        tableView.backgroundColor = fsBackgroundColor
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
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
            cell?.setupFSElements()

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
