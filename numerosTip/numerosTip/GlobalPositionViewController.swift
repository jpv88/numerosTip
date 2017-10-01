//
//  GlobalPositionViewController.swift
//  numerosTip
//
//  Created by Jared Perez Vega on 21/8/17.
//  Copyright © 2017 Jared Perez Vega. All rights reserved.
//

import UIKit

class GlobalPositionViewController: UIViewController {
    
    var controller: NumerosTipController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        controller = NumerosTipController.sharedInstance
    }

    @IBAction func actionButton(_ sender: Any) {
        controller?.llamadaServicioWeb(viewController: self){
            response in
            print("acabado")
        }
    }
    

}

