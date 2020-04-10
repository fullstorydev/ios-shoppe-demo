//
//  CartTableViewController.swift
//  ios-shoppe-demo
//
//  Created on 4/7/20.
//  Copyright © 2020 FullStory All rights reserved.
//

import Foundation
import UIKit

class CartTableViewController: UITableViewController {

    var order: Order = Order()
    var items = [Product]()

    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(order.cartOrderTotal())")

        navigationController?.navigationBar.tintColor = .white
        tableView.register(UINib(nibName: "CartTableViewCell", bundle: nil), forCellReuseIdentifier: "checkout")
        tableView.register(UINib(nibName: "CartQuantityTableViewCell", bundle: nil), forCellReuseIdentifier: "quantity")
        setOrderItemsForCart()
    }

    func setOrderItemsForCart() {
        items = order.items.filter { $0.quantity > 0 }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 2:
            return items.count
        default:
            return 1
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell =  tableView.dequeueReusableCell(withIdentifier: "checkout") as? CartTableViewCell

            cell?.tableViewController = self
            cell?.setupCartOrder()

            return cell ?? UITableViewCell()
        case 1:
            let cell = UITableViewCell()

            cell.textLabel?.font = UIFont(name: "Halvetica-Bold", size: 30)
            cell.textLabel?.textAlignment = .left
            cell.backgroundColor = .secondarySystemBackground

            cell.textLabel?.text = "Products In Cart:"

            return cell
        case 2:
            let product = items[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "quantity", for: indexPath) as? CartQuantityTableViewCell

            cell?.product = product
            cell?.tableViewController = self

            return cell ?? UITableViewCell()
        default:
            return UITableViewCell()
        }
    }
}
