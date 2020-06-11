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
    var cartNumberView = UIBarButtonItem()
    var cartNumber: Int = 0

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
                                order.items = self.products
                                self.collectionView.reloadData()
                            }
                        }
                    }
                }
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        updateCartNumber()
        setupNavigationBar()
    }

    func setupNavigationBar() {
        let barCartButton = UIBarButtonItem(image: UIImage(named: "shopping_cart"), style: .done, target: self, action: #selector(openCart))
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]

        cartNumberView = UIBarButtonItem(title: "\(cartNumber)", style: .done, target: self, action: nil)
        cartNumberView.tintColor = .white
        barCartButton.tintColor = .white

        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.barTintColor = UIColor(displayP3Red: 206/255, green: 78/255, blue: 142/255, alpha: 1.0)

        navigationItem.title = "iOS Shoppe"
        navigationItem.rightBarButtonItems = [cartNumberView, barCartButton]
        collectionView.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
    }

    @objc func openCart() {
        self.navigationController?.pushViewController(CartTableViewController(), animated: true)
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
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()

        order.addProduct(product)
        updateCartNumber()
        setupNavigationBar()
    }

    func updateCartNumber() {
        let orderItems = order.items.filter({ $0.quantity > 0 })
        var count: Int = 0

        for item in orderItems {
            count += item.quantity
        }

        cartNumber = count
    }
}
