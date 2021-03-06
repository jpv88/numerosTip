//
//  IntegerKeyboard.swift
//  numerosTip
//
//  Created by Jared Perez Vega on 16/05/2019.
//  Copyright © 2019 Jared Perez Vega. All rights reserved.
//

import UIKit

protocol CustomKeyboardProtocol {
    func changeToRomanKeyboard()
    func search()
    func changeToIntegerKeyboard()
}

class IntegerKeyboard: UIView, UIInputViewAudioFeedback {
    
    var target: UIKeyInput?
    
    var delegate: CustomKeyboardProtocol?
    
    @IBOutlet private var keyboardButtons: [UIButton]!    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        keyboardButtons.forEach { button in
            button.backgroundColor = UIColor(rgb: 0x0C77B8)
            button.layer.cornerRadius = 15
            button.layer.borderWidth = 1
            button.setTitleColor(UIColor.white, for: .normal)
            button.layer.borderColor = UIColor.black.cgColor
        }
    }
    
    @IBAction func spaceKey(_ sender: UIButton) {
        self.target?.insertText(" ")
    }
    
    @IBAction func deleteKey(_ sender: UIButton) {
        self.target?.deleteBackward()
    }
    
    @IBAction func keyPressed(_ sender: UIButton) {
        UIDevice.current.playInputClick()
        guard let text = sender.titleLabel?.text else {return}
        self.target?.insertText(text)
    }
    
    @IBAction func changeToRoman(_ sender: UIButton) {
        delegate?.changeToRomanKeyboard()
    }
    
    @IBAction func search(_ sender: UIButton) {        
        delegate?.search()
    }
    
    private func enableInputClicksWhenVisible() -> Bool {
        return true
    }
}
