//
//  Constants.swift
//  ios-shoppe-demo
//
//  Created on 8/25/20.
//  Copyright © 2020 FullStory All rights reserved.
//


import Foundation
import UIKit

typealias Nib = Constants.NibNames
typealias CellID = Constants.CellIdentifiers

/// Hard coded constants
struct Constants {
    struct TitleStrings {
        static let orderCart = "Order Cart"
        static let shoppe = "iOS Shoppe"
        static let login = "Login"
    }

    struct NibNames {
        static let productCollectionViewCell = "ProductCollectionViewCell"
        static let cartTableViewCell = "CartTableViewCell"
        static let cartQuant = "CartQuantityTableViewCell"
        static let largeLabel = "LargeLabelTableViewCell"
        static let checkBoxButton = "CheckBoxButton"
        static let checkoutTableView = "CheckoutTableViewCell"
        static let productSummaryCell = "ProductSummaryCell"
        static let productSummaryTopCell = "ProductSummaryTopCell"
        static let productSummaryUserDetailCell = "ProductSummaryUserDetailCell"
        static let productSummaryTotalCost = "ProductSummaryTotalCost"
        static let loginButtonCell = "LoginButtonViewCell"
    }

    struct CellIdentifiers {
        static let productView = "cell"
        static let checkout = "checkout"
        static let quantity = "quantity"
        static let title = "title"
        static let checkoutBox = "checkoutBox"
        static let textField = "textField"
        static let thankYou = "thankYou"
        static let userDetails = "userDetails"
        static let totalCell = "totalCell"
        static let login = "login"
    }

    struct Image {
        static let cartIcon = UIImage(named: "shopping_cart")
    }
}

struct Registry {
    var nib: [String]
    var cellID: [String]

    static let cartTableView = Registry(
        nib: [Constants.NibNames.cartTableViewCell, Constants.NibNames.cartQuant, Constants.NibNames.largeLabel],
        cellID: [Constants.CellIdentifiers.checkout, Constants.CellIdentifiers.quantity, Constants.CellIdentifiers.title]
    )

    static let checkoutTableView = Registry(
        nib: [Constants.NibNames.checkoutTableView, Constants.NibNames.largeLabel, Constants.NibNames.cartTableViewCell, Constants.NibNames.checkBoxButton],
        cellID: [Constants.CellIdentifiers.textField, Constants.CellIdentifiers.title, Constants.CellIdentifiers.checkout, Constants.CellIdentifiers.checkoutBox]
    )

    static let productSummary = Registry(
        nib: [Constants.NibNames.productSummaryCell, Constants.NibNames.productSummaryTopCell, Constants.NibNames.productSummaryUserDetailCell, Constants.NibNames.productSummaryTotalCost],
        cellID: [Constants.CellIdentifiers.quantity, Constants.CellIdentifiers.thankYou, Constants.CellIdentifiers.userDetails, Constants.CellIdentifiers.totalCell]
    )

    static let loginViewController = Registry(
        nib: [Constants.NibNames.loginButtonCell, Constants.NibNames.checkoutTableView],
        cellID: [Constants.CellIdentifiers.login, Constants.CellIdentifiers.textField]
    )
}
