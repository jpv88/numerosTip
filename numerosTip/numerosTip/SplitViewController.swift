//
//  SplitViewController.swift
//  numerosTip
//
//  Created by Jared Perez Vega on 24/04/2019.
//  Copyright © 2019 Jared Perez Vega. All rights reserved.
//

import UIKit

class SplitViewController: UISplitViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        preferredDisplayMode = .allVisible
    }

}

//extension SplitViewController: UISplitViewControllerDelegate {
//    
//    override func showDetailViewController(_ vc: UIViewController, sender: Any?) {
//        print("showing DETAIL")
//    }
//    
//    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
//        return true
//    }
//    
//}
