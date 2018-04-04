//
//  GlobalPositionViewController.swift
//  numerosTip
//
//  Created by Jared Perez Vega on 21/8/17.
//  Copyright © 2017 Jared Perez Vega. All rights reserved.
//

import UIKit

class GlobalPositionViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var controller: NumerosTipController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        controller = NumerosTipController.sharedInstance
    }
    
    func setupUI() {
        if let font = UIFont(name: "Arial-BoldItalicMT", size: 14) {
            let textColor = UIColor.white
            let textFieldBackgroundColor = UIColor(rgb: 0xCACFD2)
            searchBar.change(textFont: font, textColor: textColor, textFieldBackgroundColor: textFieldBackgroundColor)
        }
    }

    @IBAction func actionButton(_ sender: Any) {
        controller?.llamadaServicioWeb(viewController: self){
            response in
            print("acabado")
        }
    }
    

}

