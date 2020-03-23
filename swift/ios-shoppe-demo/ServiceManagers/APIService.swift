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

    var baseURL: String {
        guard let webserviceURL = getPlist(withName: "Preferences") else {
            print("No web services URL found")
            return ""
        }
        return webserviceURL[0]
    }
    

    func getShoppeItem(completion: @escaping(_:[Product]?)->()) {
        guard let url = URL(string: baseURL) else { return }

        let request = URLRequest(url: url)
        var products = [Product]()

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }

            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [Any]

                for dict in json ?? [""] {
                    products.append(Product(dict as? [String : Any] ?? [:]))
                }
                completion(products)
            }
            catch {
                print("\(error.localizedDescription)") // TODO: Add proper error handling
                completion(nil)
            }
        }.resume()
    }

    func getProductsFromFile(completion: (_ :[Product])->()) {
        var products = [Product]()

        if let path = Bundle.main.path(forResource: "Products", ofType: "json") {
            do {
                  let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                  let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? [Any]
                for dict in jsonResult ?? [] {
                    products.append(Product(dict as? [String : Any] ?? [:]))
                }
              } catch {
                   // TODO: Add proper error handling
              }
        }

        completion(products)
    }
}
