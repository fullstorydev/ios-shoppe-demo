//
//  Constants.swift
//  ios-shoppe-demo
//
//  Created on 8/25/20.
//  Copyright © 2020 FullStory All rights reserved.
//


import Foundation

typealias Nib = Constants.Nib
typealias CellID = Constants.CellID

/// Hard coded constants
struct Constants {
    struct Title {
        static let orderCart = "Order Cart"
        static let shoppe = "iOS Shoppe"
        static let login = "Login"
    }

    struct Nib {
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

    struct CellID {
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
        static let cartIcon = "shopping_cart"
    }
}

struct Registry {
    var nib: [String]
    var cellID: [String]

    static let cartTableView = Registry(
        nib: [Constants.Nib.cartTableViewCell, Constants.Nib.cartQuant, Constants.Nib.largeLabel],
        cellID: [Constants.CellID.checkout, Constants.CellID.quantity, Constants.CellID.title]
    )

    static let checkoutTableView = Registry(
        nib: [Constants.Nib.checkoutTableView, Constants.Nib.largeLabel, Constants.Nib.cartTableViewCell, Constants.Nib.checkBoxButton],
        cellID: [Constants.CellID.textField, Constants.CellID.title, Constants.CellID.checkout, Constants.CellID.checkoutBox]
    )

    static let productSummary = Registry(
        nib: [Constants.Nib.productSummaryCell, Constants.Nib.productSummaryTopCell, Constants.Nib.productSummaryUserDetailCell, Constants.Nib.productSummaryTotalCost],
        cellID: [Constants.CellID.quantity, Constants.CellID.thankYou, Constants.CellID.userDetails, Constants.CellID.totalCell]
    )

    static let loginViewController = Registry(
        nib: [Constants.Nib.loginButtonCell, Constants.Nib.checkoutTableView],
        cellID: [Constants.CellID.login, Constants.CellID.textField]
    )
}
