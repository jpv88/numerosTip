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
    
    init(obj: LanguagesDisponibility) {
        self = obj
    }
}
class GlobalPositionViewController: UIViewController {
    
    @IBOutlet weak var languageTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var controller: NumerosTipController?
    
    fileprivate var languageData: [LanguagesDisponibility]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        setupUI()
        controller = NumerosTipController.sharedInstance
        self.languageData = createDataModelLanguage()
        setupTableView()
    }
    
    func createDataModelLanguage() -> [LanguagesDisponibility] {
        var array: [LanguagesDisponibility] = []
        array.append(LanguagesDisponibility(obj: .Español))
        array.append(LanguagesDisponibility(obj: .Inglés))
        array.append(LanguagesDisponibility(obj: .Alemán))
        array.append(LanguagesDisponibility(obj: .Italiano))

        return array
        
    }
    
    private func setupTableView() {
        languageTableView.delegate = self
        languageTableView.dataSource = self
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
            let deviceType = UIDevice.current.screenType.rawValue
            if case deviceType = UIDevice.ScreenType.iPhones_5_5s_5c_SE.rawValue {
                languageConstraint.constant = 10
            }
        }
    }

    @IBAction func actionButton(_ sender: Any) {
        controller?.llamadaServicioWeb(viewController: self){
            response in
            print("acabado")
        }
    }
    

}

extension GlobalPositionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languageData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        cell.textLabel?.text = languageData[indexPath.row].getLanguage()
        cell.textLabel?.textColor = UIColor.white
        cell.backgroundColor = languageData[indexPath.row].getColor()
        let disclosureImage = UIImage(named: "chevron-right")
        let disclosureView = UIImageView(image: disclosureImage)
        disclosureView.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        disclosureView.tintColor = UIColor.white
        cell.accessoryView = disclosureView
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
