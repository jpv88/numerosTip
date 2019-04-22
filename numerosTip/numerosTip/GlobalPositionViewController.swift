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
    
    private var controller: NumerosTipController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        controller = NumerosTipController.sharedInstance
        searchBar.delegate = self
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
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
    
    // MARK: - TableView Delegate
    
    func doAction(number: String) {
        controller?.getDataFromWebService(viewController: self, number: number, completionHandler: { response in
            if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "SearchFeaturesViewController"), let vc = viewController as? SearchFeaturesViewController {
                vc.data = response
                self.navigationController?.pushViewController(viewController, animated: true)
            }
        }, serviceError: { error in
            // TODO
            print("error")
        })
    }

}


extension GlobalPositionViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else {return}
        let number = Int(text)
        if number != nil || isRomanNumber(text: text) == true {
            doAction(number: text)
        } else {
            // TODO
            print("Lanzar error: asegúrate estás introduciendo el número correctamente")
        }
    }
    
    private func isRomanNumber(text: String) -> Bool {
        let patttern = "^(?=[MDCLXVI])M*(C[MD]|D?C{0,3})(X[CL]|L?X{0,3})(I[XV]|V?I{0,3})$"
        let regex = try? NSRegularExpression(pattern: patttern, options: [.caseInsensitive])
        guard let matches = regex?.matches(in: text, options: [], range: NSRange(location: 0, length: text.count)) else {return false}
        if matches.isEmpty {
            return false
        }
        return true
    }
}
