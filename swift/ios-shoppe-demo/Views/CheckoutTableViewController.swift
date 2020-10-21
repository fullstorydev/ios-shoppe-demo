//
//  CheckoutTableViewController.swift
//  ios-shoppe-demo
//
//  Created on 4/10/20.
//  Copyright © 2020 FullStory All rights reserved.
//

import UIKit

class CheckoutTableViewController: UITableViewController {

    // MARK: - Properties

    var addressItems: [AddressDetail] = [.name, .street, .unit, .city, .state, .zip, .phone]
    var cardItems: [CardDetail] = [.name, .cardNumber, .expiration, .csv]
    var addressDict = [AddressDetail: String]()

    var autoFillEnabled: Bool = false
    var pageCanGoForward: Bool = false

    let numberOfSections: Int = 6

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Complete Order"

        registerCells(tableView: tableView, registry: Registry.checkoutTableView)

        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor().fsBackground()
    }

    // MARK: - Helper Methods

    func presentProductView() {
        if pageCanGoForward {
            let productView = ProductSummaryView()

            productView.modalPresentationStyle = .formSheet
            productView.checkoutTableViewController = self

            // MARK: FullStory Example Custom Event "Order Completed" for conversions: revenue attribution
            fsCheckoutSuccessEvent(event: .checkout, with: order)

            present(productView, animated: true, completion: nil)
        } else {
            let msg = "User tried to checkout without confirmation."
            let err: CheckoutError = CheckoutError(errorCode: "AC10XY2", message: msg, order: order)
            // MARK: FullStory Example logging
            fsLog(message: err.message, level: .error)
            fsCheckoutErrorEvent(event: .checkoutError, with: err)
        }
    }

    // MARK: - TableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfSections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0, 2, 4, 5:
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
        case 5:
            let cell =  tableView.dequeueReusableCell(withIdentifier: "checkoutBox") as? CheckBoxButtonCell
            cell?.checkoutView = self

            return cell ?? UITableViewCell()
        default:
            return UITableViewCell()
        }
    }
}
