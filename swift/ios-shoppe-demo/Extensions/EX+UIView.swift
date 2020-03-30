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
    func curveViewCornersWithShadow(cornerRadius: Float? = nil, shadowOffset: CGSize? = nil, shadowOpacity: Float? = nil, shadowRadius: Float? = nil) {
        self.layer.cornerRadius = CGFloat(cornerRadius ?? 10)
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = shadowOffset ?? CGSize(width: 3, height: 3)
        self.layer.shadowOpacity = shadowOpacity ?? 0.2
        self.layer.shadowRadius = CGFloat(shadowRadius ?? 5.0)
    }
}
