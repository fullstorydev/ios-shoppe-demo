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
    var products: [[String : Any]] = [] // TODO: Change this to be an array of class Product

    func getShoppeItem(completion: @escaping()->()) {
        guard let url = URL(string: baseURL) else { return }

        let request = URLRequest(url: url)

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }

            if let error = error {
                print("\(error.localizedDescription)") // TODO: Add proper error handling
            }

            do {
                let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [Any]

                for dict in json ?? [""] {
                    self.products.append(dict as? [String : Any] ?? [:]) // TODO: use class Product
                }
                completion()
            }
        }.resume()
    }
}
