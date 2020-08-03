//
//  Product.swift
//  ios-shoppe-demo
//
//  Created on 3/4/20.
//  Copyright © 2020 FullStory All rights reserved.
//

import Foundation
import UIKit

class Product {
    var title: String
    var description: String
    var price: Double
    var imageName: String
    var image: UIImage = UIImage()
    var unit: String
    var quantity: Int = 0

    init(_ dict: [String: Any]) {
        self.title = dict["title"] as? String ?? ""
        self.description = dict["description"] as? String ?? ""
        self.price = dict["price"] as? Double ?? -1.0
        self.imageName = dict["image"] as? String ?? ""
        self.unit = dict["unit"] as? String ?? ""
    }
    
    func getDictionary() -> [String: Any] {
        return [
            "title_str": self.title,
            "description_str": self.description,
            "price_real": self.price,
            "imageName_str": self.imageName,
            "image_str": self.image,
            "unit_str": self.unit,
            "quantity_int": self.quantity,
        ]
    }
}

func getTotal(for product: Product) -> Double {
    return product.price.multiply(product.quantity)
}
