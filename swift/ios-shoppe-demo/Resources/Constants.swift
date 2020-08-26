//
//  Constants.swift
//  ios-shoppe-demo
//
//  Created on 8/25/20.
//  Copyright © 2020 FullStory All rights reserved.
//


import Foundation

typealias nib = K.Nib
typealias cellID = K.CellID

/// Hard coded constants
struct K {
    struct Title {
        static let orderCart = "Order Cart"
        static let shoppe = "iOS Shoppe"
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

typealias Registry = ([String], [String])

let cartTableViewRegistry: Registry = (nibArr: [nib.cartTableViewCell,
                                                            nib.cartQuant,
                                                            nib.largeLabel],
                                       cellIDArr: [cellID.checkout,
                                                               cellID.quantity,
                                                               cellID.title])

let checkoutTableViewRegistry: Registry = (nibArr: [nib.checkoutTableView,
                                                                nib.largeLabel,
                                                                nib.cartTableViewCell,
                                                                nib.checkBoxButton],
                                           cellIDArr: [cellID.textField,
                                                                   cellID.title,
                                                                   cellID.checkout,
                                                                   cellID.checkoutBox])

let productSummaryRegistry: Registry = (nibArr: [nib.productSummaryCell,
                                                     nib.productSummaryTopCell,
                                                     nib.productSummaryUserDetailCell,
                                                     nib.productSummaryTotalCost],
                                        cellIDArr: [cellID.quantity,
                                                        cellID.thankYou,
                                                        cellID.userDetails,
                                                        cellID.totalCell])
let loginViewControllerRegistry: Registry = (nibArr: [nib.loginButtonCell,
                                             nib.checkoutTableView],
                                             cellID: [cellID.login,
                                                      cellID.textField])
