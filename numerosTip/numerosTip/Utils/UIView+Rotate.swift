//
//  UIView+Rotate.swift
//  numerosTip
//
//  Created by Jared Perez Vega on 24/05/2019.
//  Copyright © 2019 Jared Perez Vega. All rights reserved.
//

import UIKit

extension UIView {
    func rotate(_ toValue: CGFloat, duration: CFTimeInterval = 0.2) {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.toValue = toValue
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = "forwards"
        self.layer.add(animation, forKey: nil)
    }
}
