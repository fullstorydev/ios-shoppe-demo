//
//  EX+UITableView.swift
//  ios-shoppe-demo
//
//  Created on 10/21/20.
//  Copyright © 2020 FullStory All rights reserved.
//


import Foundation
import UIKit

extension UITableView {
    func registerCells(registry: Registry) {
        for (index, nibName) in registry.nib.enumerated() {
            self.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: registry.cellID[index])
        }
    }
}
