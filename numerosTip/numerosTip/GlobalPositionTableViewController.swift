//
//  GlobalPositionTableViewController.swift
//  numerosTip
//
//  Created by Jared Perez Vega on 24/04/2019.
//  Copyright © 2019 Jared Perez Vega. All rights reserved.
//

import UIKit
import CoreData

protocol SearchResultsSearchBarProtocol {
    func setterSearchBar(number: String)
}

class GlobalPositionTableViewController: UITableViewController {
    
    private var controller: NumerosTipController?
    private var data: NumerosTipDataModel?
    private var numberFromHistory: String?
    private var selectedPosition: Int = 1
    private var gradientLayer = CAGradientLayer()
    var delegate: SearchResultsSearchBarProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        controller = NumerosTipController.sharedInstance
        setupTable()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        gradientLayer.frame = CGRect(x: 0, y: 0, width: self.tableView.bounds.width, height: self.tableView.bounds.height + 20)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setGradientBackground()
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        if let number = numberFromHistory {
            getNumberTIP(number: number)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        numberFromHistory = nil
    }
    
    // MARK: - SetUp
    
    private func setupTable(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tapGesture.cancelsTouchesInView = false
        tableView.addGestureRecognizer(tapGesture)
        tableView.delegate = self
        tableView.dataSource = self
        let mainNib = UINib(nibName: "MainTableViewCell", bundle: nil)
        let tabsNib = UINib(nibName: "TabsTableViewCell", bundle: nil)
        tableView.register(mainNib, forCellReuseIdentifier: "MainTableViewCell")
        tableView.register(tabsNib, forCellReuseIdentifier: "TabsTableViewCell")
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
    }
    
    private func setGradientBackground() {
        let leftColor = UIColor(rgb: 0x0C77B8)
        let rightColor = UIColor(rgb: 0x0C3B5D)
        let gradientBackgroundColors = [leftColor.cgColor, rightColor.cgColor]
        let gradientLocations = [0.0, 1.0]
        gradientLayer.colors = gradientBackgroundColors
        gradientLayer.locations = gradientLocations as [NSNumber]
        gradientLayer.startPoint = CGPoint(x: 0, y: 1)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = CGRect(x: 0, y: 0, width: self.tableView.bounds.width, height: self.tableView.bounds.height)
        let backgroundView = UIView(frame: self.tableView.bounds)
        backgroundView.layer.insertSublayer(gradientLayer, at: 0)
        self.tableView.backgroundView = backgroundView
    }
    
    // MARK: - Helpers
    
    private func isRomanNumber(text: String) -> Bool {
        let patttern = "^(?=[MDCLXVI])M*(C[MD]|D?C{0,3})(X[CL]|L?X{0,3})(I[XV]|V?I{0,3})$"
        let regex = try? NSRegularExpression(pattern: patttern, options: [.caseInsensitive])
        guard let matches = regex?.matches(in: text, options: [], range: NSRange(location: 0, length: text.count)) else {return false}
        if matches.isEmpty {
            return false
        }
        return true
    }
    
    @objc private func handleTap(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    private func resetScreen() {
        data = nil
        if UIDevice().iPad {
            selectedPosition = 1
            self.performSegue(withIdentifier: "segueDetail1", sender: nil)
        }
        tableView.reloadData()
    }
    
     // MARK: - Navigation

     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueDetail2" {
            if let navigation = segue.destination as? UINavigationController {
                if let vc = navigation.viewControllers[0] as? ResultDetailViewController {
                    if let element = data?.tabsArray[selectedPosition] {
                        vc.data = element
                    }
                }
            }
        }
     }
    
    
    // MARK: - Table view
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 420
        default:
            return 60
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let elements = data?.tabsArray {
            return elements.count + 1
        }
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
            cell.delegate = self
            self.delegate = cell
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TabsTableViewCell", for: indexPath) as? TabsTableViewCell else { return UITableViewCell() }
            if let title = data?.tabsArray[indexPath.row - 1].title {
                var titleCleaned = title
                if titleCleaned.contains("#") {
                    titleCleaned = titleCleaned.replacingOccurrences(of: "#", with: "")
                }
                cell.displayContent(input: titleCleaned)
            }
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            break
        default:
            selectedPosition = indexPath.row - 1
            self.performSegue(withIdentifier: "segueDetail2", sender: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == 1, let _ = numberFromHistory, UIDevice().iPad {
            selectedPosition = 0
            self.performSegue(withIdentifier: "segueDetail2", sender: nil)
        }
    }
    
    // MARK: - API
    
    private func getNumberTIP(number: String) {
        controller?.getDataFromWebService(viewController: self, number: number, completionHandler: { response in
            self.saveHistory(number: number.uppercased())
            self.data = response
            self.tableView.reloadData()
        }, serviceError: { error in
            ErrorHandler.showError(error: error)
        })
    }
    
    // MARK: - CoreData
    
    private func saveHistory(number: String){
        if retrieveHistory() {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
            let context = appDelegate.persistenContainer.viewContext
            context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            
            guard let entity = NSEntityDescription.entity(forEntityName: "History", in: context) else {return}
            let history = NSManagedObject(entity: entity, insertInto: context)
            history.setValue(number, forKey: "number")
            do {
                try context.save()
            } catch let error {
                ErrorHandler.showError(error: error)
            }
        }
    }
    
    private func retrieveHistory() -> Bool {
        let userDefault = UserDefaults.standard
        guard let historyMaxElements = userDefault.object(forKey: Constans.historyKEY) as? Int else {return false}
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return false}
        let context = appDelegate.persistenContainer.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "History")
        do {
            guard let result = try context.fetch(fetchRequest) as? [NSManagedObject] else {return false}
            var elements = [String]()
            for data in result {
                if let number = data.value(forKey: "number") as? String {
                    elements.append(number)
                }
            }
            if elements.count < historyMaxElements {
                return true
            }
            return false
        } catch let error {
            ErrorHandler.showError(error: error)
        }
        return false
    }
    
}

extension GlobalPositionTableViewController: MainTableViewCellProtocol {
    func clearResults() {
        resetScreen()
    }
    
    func settingsIconTapped() {
        let storyboard = UIStoryboard(name: "Settings", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "SettingsViewController") as? UINavigationController else {return}
        if let vc = viewController.viewControllers[0] as? SettingsViewController {
            vc.delegate = self
        }
        self.splitViewController?.present(viewController, animated: true, completion: nil)
    }
    
    func searchFieldDidReturn(_ text: String) {
        let number = Int(text)
        if number != nil || isRomanNumber(text: text) == true {
            getNumberTIP(number: text)
        } else {            
            ErrorHandler.showAlert(title: "Incorrecto", msg: "Asegúrate que estás introduciendo el número correctamente")
        }
    }
}

// MARK: - SettingsHistoryProtocol
extension GlobalPositionTableViewController: SettingsHistoryProtocol {
    
    func didSelectHistory(number: String) {
        delegate?.setterSearchBar(number: number)
        numberFromHistory = number
    }
    
}
