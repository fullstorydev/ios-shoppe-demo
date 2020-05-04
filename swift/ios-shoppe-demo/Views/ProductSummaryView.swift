//
//  ProductSummaryView.swift
//  ios-shoppe-demo
//
//  Created by Harold Davis Jr. on 4/30/20.
//  Copyright © 2020 Harold Davis Jr. All rights reserved.
//

import Foundation
import UIKit

class ProductSummaryView: UITableViewController {
    var checkoutTableViewController: CheckoutTableViewController!
    var purchasedItems: [Product] {
        return order.items.filter { return $0.quantity > 0 }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "ProductSummaryCell", bundle: nil), forCellReuseIdentifier: "quantity")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        checkoutTableViewController.navigationController?.popToRootViewController(animated: true)
    }

    @objc func dismissBacktoRoot() {
        checkoutTableViewController.navigationController?.popToRootViewController(animated: true)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return purchasedItems.count
        default:
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell =  UITableViewCell()
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.text = user?.description()

            return cell
        case 1:
            let product = purchasedItems[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "quantity", for: indexPath) as? ProductSummaryCell

            cell?.product = product

            return cell ?? UITableViewCell()
        default:
            return UITableViewCell()
        }
    }
}
