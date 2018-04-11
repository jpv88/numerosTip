//
//  GlobalPositionViewController.swift
//  numerosTip
//
//  Created by Jared Perez Vega on 21/8/17.
//  Copyright © 2017 Jared Perez Vega. All rights reserved.
//

import UIKit

enum LanguagesDisponibility {
    case Español
    case Inglés
    case Alemán
    case Italiano
    
    func getLanguage() -> String {
        switch self {
        case .Español:
            return "Español"
        case .Inglés:
            return "Inglés"
        case .Alemán:
            return "Alemán"
        case .Italiano:
            return "Italiano"
        }
    }
    
    func getColor() -> UIColor {
        switch self {
        case .Español:
            return UIColor(rgb: 0x95CBEE)
        case .Inglés:
            return UIColor(rgb: 0x74B5DD)
        case .Alemán:
            return UIColor(rgb: 0x3B98C6)
        case .Italiano:
            return UIColor(rgb: 0x1A7A9F)
        }
    }
}
class GlobalPositionViewController: UIViewController, LanguageActionsProtocol {
    
    @IBOutlet weak var languageTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var languageTableViewController: LanguageTableViewController?
    private var controller: NumerosTipController?
    
    fileprivate var languageData: [LanguagesDisponibility]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        controller = NumerosTipController.sharedInstance
        self.languageData = Helper.getArrayFromEnumCases(enumType: LanguagesDisponibility.self)
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    private func setupTableView() {
        languageTableViewController = LanguageTableViewController(data: languageData)
        languageTableViewController?.delegate = self
        languageTableView.delegate = languageTableViewController
        languageTableView.dataSource = languageTableViewController
        languageTableView.rowHeight = 60.0
        languageTableView.bounces = false
    }
    
    private func setupUI() {
        if let font = UIFont(name: "Arial-BoldItalicMT", size: 14) {
            let textColor = UIColor.white
            let textFieldBackgroundColor = UIColor(rgb: 0xCACFD2)
            searchBar.change(textFont: font, textColor: textColor, textFieldBackgroundColor: textFieldBackgroundColor)
        }
        let filteredConstraints = self.view.constraints.filter{ $0.identifier == "languageInformationConstraint" }
        if let languageConstraint = filteredConstraints.first {            
            if case UIDevice.current.screenType.rawValue = UIDevice.ScreenType.iPhones_5_5s_5c_SE.rawValue {
                languageConstraint.constant = 10
            }
        }
    }
    
    // MARK: - TableView Delegate
    
    func doAction() {
        print("accion...!")
        controller?.llamadaServicioWeb(viewController: self){
            response in
            print("acabado")
            if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "SearchFeaturesViewController") {
                self.navigationController?.pushViewController(viewController, animated: true)
            }
        }
    }

}
