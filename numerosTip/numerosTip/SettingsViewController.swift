//
//  SettingsViewController.swift
//  numerosTip
//
//  Created by Jared Perez Vega on 02/05/2019.
//  Copyright © 2019 Jared Perez Vega. All rights reserved.
//

import UIKit
import CoreData

enum Language: String {
    case es
    case en
    case it
    case de
}

extension Language {
    
    init(position: Int) {
        switch position {
        case 0:
            self = Language.es
        case 1:
            self = Language.en
        case 2:
            self = Language.it
        case 3:
            self = Language.de
        default:
            self = Language.es
        }
    }
    var position: Int {
        switch self {
        case .es:
            return 0
        case .en:
            return 1
        case .it:
            return 2
        case .de:
            return 3
        }
    }
}

protocol SettingsHistoryProtocol {
    func didSelectHistory(number: String)
}

class SettingsViewController: UIViewController {
    
    // 0 -> ES, 1 -> EN, 2 -> IT, 3 -> AL
    @IBOutlet var languageCollectionView: Array<UIView>!
    @IBOutlet var historyTableView: UITableView!
    
    private var data: [String]?
    
    var delegate: SettingsHistoryProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLanguage()
        retrieveHistory()
        setupTable()
    }
    
    // MARK: - Setup
    
    private func setupLanguage() {
        let userDefault = UserDefaults.standard
        guard let language = userDefault.object(forKey: Constans.languageKEY) as? String else {return}
        guard let object = Language(rawValue: language.lowercased()) else {return}
        for (index, _) in languageCollectionView.enumerated() {
            let tap = UITapGestureRecognizer(target: self, action: #selector(handleLanguageViewTap(sender:)))
            languageCollectionView[index].addGestureRecognizer(tap)
            languageCollectionView[index].isUserInteractionEnabled = true
            if index == object.position {
                languageCollectionView[index].backgroundColor = .lightGray
            } else {
                languageCollectionView[index].backgroundColor = .white
            }
        }
    }
    
    private func setupTable() {
        historyTableView.delegate = self
        historyTableView.dataSource = self
        let tabsNib = UINib(nibName: "TabsTableViewCell", bundle: nil)
        historyTableView.register(tabsNib, forCellReuseIdentifier: "TabsTableViewCell")
        historyTableView.tableFooterView = UIView()
        historyTableView.separatorStyle = .none
    }
    
    // MARK: - Dismiss
    
    @IBAction func closeSettings(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Helpers
    
    @objc private func handleLanguageViewTap(sender: UITapGestureRecognizer) {
        guard let viewTag = sender.view?.tag else {return}
        let language = Language(position: viewTag)
        let userDefault = UserDefaults.standard
        userDefault.set(language.rawValue, forKey: Constans.languageKEY)
        setupLanguage()
    }
    
    @IBAction func deleteHistory(_ sender: UIButton) {
        eraseData()
        data = nil
        historyTableView.reloadData()
    }
    
    // MARK: - CoreData
    
    private func retrieveHistory() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = appDelegate.persistenContainer.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "History")
        do {
            guard let result = try context.fetch(fetchRequest) as? [NSManagedObject] else {return}
            var elements = [String]()
            for data in result {
                if let number = data.value(forKey: "number") as? String {
                    elements.append(number)
                }
            }
            data = elements
            historyTableView.reloadData()
        } catch let error {
            ErrorHandler.showError(error: error)
        }
    }
    
    private func eraseData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = appDelegate.persistenContainer.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "History")
        do {
            guard let elements = try context.fetch(fetchRequest) as? [NSManagedObject] else {return}
            for element in elements {
                context.delete(element)
            }
            do {
                try context.save()
            } catch let error {
                ErrorHandler.showError(error: error)
            }
        } catch let error {
            ErrorHandler.showError(error: error)
        }
    }
    
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let elements = data?.count {
            return elements
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TabsTableViewCell") as? TabsTableViewCell else {return UITableViewCell()}
        if let data = data {            
            cell.displayContent(input: data[indexPath.row], with: .lightGray)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let data = data {
            delegate?.didSelectHistory(number: data[indexPath.row])
            dismiss(animated: true, completion: nil)
        }
    }
}
