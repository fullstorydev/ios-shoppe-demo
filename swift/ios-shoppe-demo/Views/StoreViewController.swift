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

    // MARK: - NavigationBar Button Properties

    var barCartButton: UIBarButtonItem {
        let button = UIBarButtonItem(image: UIImage(named: "shopping_cart"), style: .done, target: self, action: #selector(openCart))
        button.tintColor = .white
        return button
    }

    var cartNumberView: UIBarButtonItem = UIBarButtonItem() {
        didSet {
            cartNumberView.tintColor = .white
        }
    }

    var cartNumber: Int = 0 {
        didSet {
            setCartUI()
        }
    }

    // MARK: - View Life Cycle

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
                                order.setItems(items: self.products)
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
    }

    // MARK: - UI Methods

    func setupNavigationBar() {
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]

        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.barTintColor = UIColor(displayP3Red: 206/255, green: 78/255, blue: 142/255, alpha: 1.0)

        navigationItem.title = "iOS Shoppe"

        setCartUI()

        collectionView.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        collectionView.backgroundColor = UIColor().fsBackground()
    }

    func updateCartNumber() {
        let numberOfItems = order.getNumberOfItems()

        cartNumber = numberOfItems
    }

    func setCartUI() {

        cartNumberView = UIBarButtonItem(title: "\(cartNumber)", style: .done, target: self, action: nil)
        navigationItem.rightBarButtonItems = [cartNumberView, barCartButton]
    }

    func addToCart(_ product: String) {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()

        order.addProduct(product)
        updateCartNumber()
    }

    @objc func openCart() {
        self.navigationController?.pushViewController(CartTableViewController(), animated: true)
    }

    // MARK: - CollectionViewDelegate Methods

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
}
