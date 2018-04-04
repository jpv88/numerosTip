//
//  UISearchBar+Extension.swift
//  numerosTip
//
//  Created by Jared Perez Vega on 4/4/18.
//  Copyright © 2018 Jared Perez Vega. All rights reserved.
//

import UIKit

extension UISearchBar {
    
    func change(textFont : UIFont) {
        for view : UIView in (self.subviews[0]).subviews {
            if let textField = view as? UITextField {
                textField.font = textFont
            }
        }
    }
    
    func change(textFont: UIFont, textColor: UIColor) {
        for view : UIView in (self.subviews[0]).subviews {
            if let textField = view as? UITextField {
                textField.font = textFont
                textField.textColor = textColor
            }
        }
    }
    
    func change(textFont: UIFont, textColor: UIColor, textFieldBackgroundColor: UIColor) {
        for view : UIView in (self.subviews[0]).subviews {
            if let textField = view as? UITextField {
                textField.font = textFont
                textField.textColor = textColor
                textField.backgroundColor = textFieldBackgroundColor
            }
        }
    }
    
}
