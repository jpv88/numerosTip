//
//  SplitViewController.swift
//  numerosTip
//
//  Created by Jared Perez Vega on 24/04/2019.
//  Copyright © 2019 Jared Perez Vega. All rights reserved.
//

import UIKit

class SplitViewController: UISplitViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        preferredDisplayMode = .allVisible
    }
}
