//
//  ProductCollectionViewCell.swift
//  ios-shoppe-demo
//
//  Created on 3/25/20.
//  Copyright © 2020 FullStory All rights reserved.
//

import Foundation
import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    @IBOutlet weak var addToCartButton: UIButton!

    var product: Product! {
        didSet {
            setup()
        }
    }

    var collectionView: StoreViewController?

    func setup() {

        DispatchQueue.main.async {
            self.curveViewCornersWithShadow()
            self.addToCartButton.curveViewCornersWithShadow()
            self.productTitleLabel.text = self.product.title
            self.productPriceLabel.text = "Price: \(self.product.price.toCurrency())"
            self.productDescriptionLabel.text = self.product.description
            self.productImageView.image = self.product.image
        }
    }

    @IBAction func addProductToCart(_ sender: Any) {
        collectionView?.addToCart(product.title)
    }
}
