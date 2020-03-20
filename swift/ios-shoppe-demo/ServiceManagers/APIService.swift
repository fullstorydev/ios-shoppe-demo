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
    
    var products = [Product]()

    func getShoppeItem(completion: @escaping()->()) {
        guard let url = URL(string: baseURL) else { return }

        let request = URLRequest(url: url)

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }

            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [Any]

                for dict in json ?? [""] {
                    self.products.append(Product(dict as? [String : Any] ?? [:]))
                }
                completion()
            }
            catch {
                print("\(error.localizedDescription)") // TODO: Add proper error handling
                completion()
            }
        }.resume()
    }
}
