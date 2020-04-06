//
//  CartTableViewController.swift
//  ios-shoppe-demo
//
//  Created on 4/2/20.
//  Copyright © 2020 FullSTory All rights reserved.
//

import Foundation
import UIKit

class CartTableViewController: UITableViewController {
    var orderManager = OrderManager.sharedInstance
    var productsRecordedForView = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(orderManager.cartOrderTotal())")

        navigationController?.navigationBar.tintColor = .white
        tableView.register(UINib(nibName: "CartTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell2")
        setProductArray()
    }

    func setProductArray() {
        orderManager.currentOrder?.items.forEach({ (prod) in
            if !productsRecordedForView.contains(prod.title) {
                productsRecordedForView.append(prod.title)
            }
        })
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 3:
            return productsRecordedForView.count
        default:
            return 1
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell =  tableView.dequeueReusableCell(withIdentifier: "cell") as? CartTableViewCell

            cell?.tableViewController = self
            cell?.setupCartOrder()

            return cell ?? UITableViewCell()
        case 1:
            let cell = UITableViewCell()

            cell.textLabel?.font = UIFont(name: "Halvetica-Bold", size: 30)
            cell.textLabel?.textAlignment = .left
            cell.textLabel?.textColor = .systemIndigo

            cell.textLabel?.text = "Products In Cart:"

            return cell
        default:
            let product = productsRecordedForView[indexPath.row]
            let quantity = orderManager.getCostForProduct(product)
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath)

            productsRecordedForView.append(product)

            cell.textLabel?.text = product
            cell.detailTextLabel?.text = "x\(String(describing: quantity))"

            return cell
        }
    }
}
