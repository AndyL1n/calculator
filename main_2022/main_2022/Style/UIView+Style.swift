//
//  UIView+Style.swift
//  main_2022
//
//  Created by Andy on 2022/3/5.
//

import UIKit

extension UIView {
    public func makeBorder(borderColor: UIColor, borderWidth: CGFloat) {
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
    }
    
    public func makeRadius(radius: CGFloat) {
        self.layer.cornerRadius = radius
    }
    
    public func makeRadiusForEachCorner(radius: CGFloat, corners: CACornerMask?) {
        self.layer.cornerRadius = radius
        
        if let corners = corners {
            self.layer.maskedCorners = corners
        }
    }
}
