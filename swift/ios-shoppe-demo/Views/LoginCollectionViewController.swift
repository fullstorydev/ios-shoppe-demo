//
//  LoginCollectionViewController.swift
//  ios-shoppe-demo
//
//  Created on 8/18/20.
//  Copyright © 2020 FullStory All rights reserved.
//


import UIKit

class LoginCollectionViewController: UITableViewController {

    var userName: String?
    var userEmail: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        registerCellsNibs()
    }

    // Register cell classes

    func registerCellsNibs() {
        navigationItem.title = Constants.Title.login
        navigationController?.navigationBar.tintColor = .white
        registerCells(tableView: tableView, registry: loginViewControllerRegistry)
    }

    func login() {
        guard let userName = userName, let userEmail = userEmail else {
            return
        }
        user = UserProfile(addressDetail: [.name:userName, .email: userEmail])
    }

    // MARK: UITableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.row {
        case 0:
            let cell = UITableViewCell()
            cell.sizeThatFits(CGSize(width: tableView.window?.screen.bounds.width ?? 0, height: 350))

            return UITableViewCell(frame: CGRect())
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "textField", for: indexPath) as? CheckoutTableViewCell


            return cell ?? UITableViewCell()
        default:
            return UITableViewCell()
        }

    }
}
