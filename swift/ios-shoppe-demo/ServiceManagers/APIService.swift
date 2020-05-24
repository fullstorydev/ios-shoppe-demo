//
//  APIService.swift
//  ios-shoppe-demo
//
//  Created on 3/4/20.
//  Copyright © 2020 FullStory All rights reserved.
//

import Foundation
import UIKit

class APIService {
    static var sharedInstance = APIService()

    var baseURL: String {
        if let url = getPreferencesArray()["baseURL"] {
            return url
        }
        else {
            print("No url found from Preferences file!")
            return ""
        }
    }

    var baseImageURL: String {
        if let url = getPreferencesArray()["baseImageURL"] {
            return url
        }
        else {
            print("No url found from Preferences file!")
            return ""
        }
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
                completion(nil)
            }
        }.resume()
    }

    func getImageFor(_ productName: String, completion: @escaping(_ image: UIImage?, _ error: NSError?)->()) {
        guard let url = URL(string: baseImageURL + productName) else { return }

        DispatchQueue.main.async {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    completion(UIImage(data: data), nil)
                }
                else {
                    if let error = error {
                        completion(nil, error as NSError)
                    }
                }
            }.resume()
        }
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
              } catch { }
        }

        completion(products)
    }

    func getPreferencesArray() -> [String: String] {
        guard let webserviceURL = getPlist(withName: "Preferences") else {
            print("No web services URL found")
            return [:]
        }

        return webserviceURL
    }
}
