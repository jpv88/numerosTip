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
    func search(input: String)
    func changeToIntegerKeyboard()
}

class IntegerKeyboard: UIView, UIInputViewAudioFeedback {
    
    var target: UIKeyInput?
    
    var delegate: CustomKeyboardProtocol?
    
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
        guard let text = sender.titleLabel?.text else {return}
        delegate?.search(input: text)
    }
    
    private func enableInputClicksWhenVisible() -> Bool {
        return true
    }
}
