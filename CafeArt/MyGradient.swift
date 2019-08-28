//
//  MyGradient.swift
//  CafeArt
//
//  Created by Apple on 6/2/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func setGradientBackground(colorOne: UIColor, colorTwo: UIColor , colorThree: UIColor) {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor, colorThree.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x:0 , y:0 )
        layer.insertSublayer(gradientLayer, at: 0)
    }
    

}
