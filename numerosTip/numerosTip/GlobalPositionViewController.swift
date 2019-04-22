//
//  GlobalPositionViewController.swift
//  numerosTip
//
//  Created by Jared Perez Vega on 21/8/17.
//  Copyright © 2017 Jared Perez Vega. All rights reserved.
//

import UIKit
    
//    return UIColor(rgb: 0x95CBEE)
//    return UIColor(rgb: 0x74B5DD)
//    return UIColor(rgb: 0x3B98C6)
//    return UIColor(rgb: 0x1A7A9F)
    
class GlobalPositionViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var controller: NumerosTipController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        controller = NumerosTipController.sharedInstance
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    private func setupTableView() {
//        languageTableViewController = LanguageTableViewController()
//        languageTableViewController?.delegate = self
//        languageTableView.delegate = languageTableViewController
//        languageTableView.dataSource = languageTableViewController
//        languageTableView.rowHeight = 60.0
//        languageTableView.bounces = false
    }
    
    private func setupUI() {
        if let font = UIFont(name: "Arial-BoldItalicMT", size: 14) {
            let textColor = UIColor.white
            let textFieldBackgroundColor = UIColor(rgb: 0xCACFD2)
            searchBar.change(textFont: font, textColor: textColor, textFieldBackgroundColor: textFieldBackgroundColor)
        }
    }
    
    // MARK: - TableView Delegate
    
    func doAction() {
        controller?.getDataFromWebService(viewController: self, completionHandler: { response in
            if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "SearchFeaturesViewController"), let vc = viewController as? SearchFeaturesViewController {
                vc.data = response
                self.navigationController?.pushViewController(viewController, animated: true)
            }
        }, serviceError: { error in
            print("error")
        })
    }

}
