//
//  StaticDetailViewController.swift
//  numerosTip
//
//  Created by Jared Perez Vega on 26/04/2019.
//  Copyright © 2019 Jared Perez Vega. All rights reserved.
//

import UIKit

class StaticDetailViewController: UIViewController {
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var navigationItemStaticView: UINavigationItem!
    private var gradientLayer = CAGradientLayer()
    
    private enum Localizables {
        static let navBarTitle = "no_results_navBar_title".localized()
        static let title = "no_results_title".localized()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        setup()
        setGradientBackground()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()        
       gradientLayer.frame = self.view.bounds
    }
    
    private func setup() {
        titleLabel.text = Localizables.title
        navigationItemStaticView.title = Localizables.navBarTitle
    }
    
    private func setGradientBackground() {
        let leftColor = UIColor(rgb: 0x0C77B8).cgColor
        let rightColor = UIColor(rgb: 0x0C3B5D).cgColor
        gradientLayer.colors = [leftColor, rightColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0, y: 1)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = self.view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
}
