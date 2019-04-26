//
//  StaticDetailViewController.swift
//  numerosTip
//
//  Created by Jared Perez Vega on 26/04/2019.
//  Copyright © 2019 Jared Perez Vega. All rights reserved.
//

import UIKit

class StaticDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if let splitView = self.navigationController?.splitViewController, !splitView.isCollapsed {
            self.navigationItem.leftBarButtonItem = splitView.displayModeButtonItem
        }
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        setGradientBackground()
    }
    
    func setGradientBackground() {
        let leftColor = UIColor(rgb: 0x0C77B8).cgColor
        let rightColor = UIColor(rgb: 0x0C3B5D).cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [leftColor, rightColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0, y: 1)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = self.view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
}
