//
//  APIService.swift
//  ios-shoppe-demo
//
//  Created on 3/4/20.
//  Copyright © 2020 FullStory All rights reserved.
//

import Foundation

class APIService {
    static var sharedInstance = APIService()

    var baseURL: String = "http://reactshoppe.s3-website-us-east-1.amazonaws.com/data/products.json"
    var shopItems: [[String : Any]] = [] // TODO: Change this to be an array of class ShopItem

    func getShoppeItem(completion: @escaping()->()) {
        guard let url = URL(string: baseURL) else { return }

        let request = URLRequest(url: url)

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            guard error != nil else { return }

            do {
                let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [Any]

                for dict in json ?? [""] {
                    self.shopItems.append(dict as? [String : Any] ?? [:]) // TODO: use class ShopItem
                }
                completion()
            }
        }.resume()
    }
}
