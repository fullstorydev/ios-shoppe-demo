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
    var price: String
    var imageName: String
    var image: UIImage = UIImage()
    var unit: String

    init(_ dict: [String: Any]) {
        self.title = dict["title"] as? String ?? ""
        self.description = dict["description"] as? String ?? ""
        self.price = dict["price"] as? String ?? ""
        self.imageName = dict["image"] as? String ?? ""
        self.unit = dict["unit"] as? String ?? ""
    }
}
