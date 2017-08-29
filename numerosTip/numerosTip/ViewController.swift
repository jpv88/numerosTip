//
//  ViewController.swift
//  numerosTip
//
//  Created by Jared Perez Vega on 21/8/17.
//  Copyright © 2017 Jared Perez Vega. All rights reserved.
//

import UIKit

class ViewController: UIViewController, networkingActionsDelegate {

    @IBOutlet weak var inputTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func actionButton(_ sender: Any) {
        Network.delegate = self
        Network.requestWebService(reference: self)
    }    
    
    // MARK:- Network Delegate
    
    func doActions(){
        
    }

}

