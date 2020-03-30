//
//  EX+UIView.swift
//  ios-shoppe-demo
//
//  Created on 3/30/20.
//  Copyright © 2020 FullStory All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func curve() {
        self.layer.cornerRadius = 20
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 4.0
    }

    func smallCurve() {
        self.layer.cornerRadius = 10
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 5.0
    }

    func xtreamCurve() {
        self.layer.cornerRadius = 40
    }
}
