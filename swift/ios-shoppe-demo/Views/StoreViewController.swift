//
//  ViewController.swift
//  ios-shoppe-demo
//
//  Created on 3/3/20.
//  Copyright © 2020 FullStory All rights reserved.
//

import UIKit

class StoreViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var products: [Product] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.backgroundColor = .white
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        APIService.sharedInstance.getProductsFromFile { (productsRecieved) in
            if !productsRecieved.isEmpty {
                self.products = productsRecieved
                self.collectionView.reloadData()
            }
        }
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        let product = products[indexPath.row]

        let productTextLabel = UILabel()
        productTextLabel.text = product.title
        productTextLabel.contentMode = .left
        productTextLabel.lineBreakMode = .byTruncatingHead
        productTextLabel.translatesAutoresizingMaskIntoConstraints = false

        cell.addSubview(productTextLabel)
        // TODO: Make an extension off of UIView that can accept a dictionary of [UIView : anchor multiplier valus] to clean up this implementation.
        productTextLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: cell.leadingAnchor, multiplier: 0).isActive = true
        productTextLabel.trailingAnchor.constraint(greaterThanOrEqualToSystemSpacingAfter: cell.trailingAnchor, multiplier: 0).isActive = true
        productTextLabel.superview?.topAnchor.constraint(equalToSystemSpacingBelow: cell.topAnchor, multiplier: 0).isActive = true
        productTextLabel.superview?.bottomAnchor.constraint(greaterThanOrEqualToSystemSpacingBelow: cell.bottomAnchor, multiplier: 0).isActive = true

        cell.backgroundColor = .systemGray2

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 350, height: 200)
    }
}
