//
//  ViewController.swift
//  ios-shoppe-demo
//
//  Created on 3/3/20.
//  Copyright © 2020 FullStory All rights reserved.
//

import UIKit

public var username: String?

class StoreViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var products: [Product] = []
    var order: Order = Order()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()

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
                                self.order.items = self.products
                                self.collectionView.reloadData()
                            }
                        }
                    }
                }
            }
        }
    }

    func setupNavigationBar() {
        let barCartButton = UIBarButtonItem(image: UIImage(named: "shopping_cart"), style: .done, target: self, action: #selector(openCart))
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]

        barCartButton.tintColor = .white

        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.barTintColor = UIColor(displayP3Red: 206/255, green: 78/255, blue: 142/255, alpha: 1.0)

        navigationItem.title = "iOS Shoppe"
        navigationItem.rightBarButtonItem = barCartButton

        collectionView.backgroundColor = .white
        collectionView.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
    }

    @objc func openCart() {
        // TODO: Present Cart View controller
        let vc = CartTableViewController()
        vc.order = order
        self.navigationController?.pushViewController(vc, animated: true)
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
        cell?.collectionView = self
        
        return cell ?? UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 375, height: 300)
    }

    func addToCart(_ product: String) {
        order.addProduct(product)
    }
}
