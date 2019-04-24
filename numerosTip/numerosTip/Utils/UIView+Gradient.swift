//
//  UIView+Gradient.swift
//  numerosTip
//
//  Created by Jared Perez Vega on 24/04/2019.
//  Copyright © 2019 Jared Perez Vega. All rights reserved.
//

import UIKit

extension UIView {
    
    public func applyGradient(firstColour: UIColor, secondColor: UIColor, startPoint: CGPoint = CGPoint(x: 0.0, y: 0.5), endPoint: CGPoint = CGPoint(x: 1.0, y: 0.5)) -> Void {
        self.applyGradient(colours: [firstColour, secondColor], startPoint: startPoint, endPoint: endPoint, locations: nil)
    }
    
    private func applyGradient(colours: [UIColor], startPoint: CGPoint, endPoint: CGPoint, locations: [NSNumber]?) -> Void {
        self.layoutIfNeeded()
        
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        
        if layer.cornerRadius != 0 {
            gradient.cornerRadius = layer.cornerRadius
        }
        
        if let oldGradient = layer.sublayers?[0] as? CAGradientLayer {
            layer.replaceSublayer(oldGradient, with: gradient)
        } else {
            layer.insertSublayer(gradient, below: nil)
        }
    }
    
}
