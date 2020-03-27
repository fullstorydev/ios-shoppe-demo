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

        self.navigationController?.navigationBar.barTintColor = .systemIndigo
        collectionView.backgroundColor = .white
        collectionView.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")


        APIService.sharedInstance.getProductsFromFile { (productsRecieved) in
            if !productsRecieved.isEmpty {
                self.products = productsRecieved
                self.products.forEach { (item) in
                    APIService.sharedInstance.getImageFor(item.imageName) { (image, error) in
                        if let error = error {
                            print(error.description)
                        }
                        else if let image = image {
                            item.image = image
                            DispatchQueue.main.async {
                                self.collectionView.reloadData()
                            }
                        }
                    }
                }
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

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ProductCollectionViewCell
        cell?.product = products[indexPath.row]

        return cell ?? UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 375, height: 300)
    }
}
