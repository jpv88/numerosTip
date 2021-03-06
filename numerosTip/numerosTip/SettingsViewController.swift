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
    @IBOutlet private var languageCollectionView: Array<UIView>!
    @IBOutlet private var historyTableView: UITableView!
    @IBOutlet private var languageTitleLabel: UILabel!
    @IBOutlet private var historyTitleLabel: UILabel!
    @IBOutlet private var deleteHistoryButton: UIButton!
    @IBOutlet private var settingsNavigationItem: UINavigationItem!
    @IBOutlet private var collapsibleLabel: UILabel!
    @IBOutlet private var collapsibleSwitch: UISwitch!
    @IBOutlet private var historyLimitsPickerView: UIPickerView!
    @IBOutlet private var historyLimitsLabel: UILabel!
    
    private var data: [HistoryDataModel]?
    
    var delegate: SettingsHistoryProtocol?
    
    private enum Localized {
        static let navBarTitle = "settings_navBar_title".localized()
        static let languageTitle = "settings_language_title".localized()
        static let historyTitle = "settings_history_title".localized()
        static let historyDelete = "settings_history_delete".localized()
        static let es = "general_language_spanish".localized()
        static let en = "general_language_english".localized()
        static let it = "general_language_italian".localized()
        static let de = "general_language_german".localized()
        static let collapsibleTitle = "settings_collapsible_title".localized()
        static let safeDelete = "settings_history_safe_delete".localized()
        static let historyLimitsTitle = "settings_history_limits_title".localized()
        static let accept = "general_accept".localized()
        static let cancel = "general_cancel".localized()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupLanguage()
        setupPicker()
        collapsibleSwitch.isOn = retrieveCollapsibleElements()
        retrieveHistory()
        setupTable()
    }
    
    // MARK: - Setup
    
    private func setup() {
        settingsNavigationItem.title = Localized.navBarTitle
        languageTitleLabel.text = Localized.languageTitle
        historyTitleLabel.text = Localized.historyTitle
        deleteHistoryButton.setTitle(Localized.historyDelete, for: .normal)
        collapsibleLabel.text = Localized.collapsibleTitle
        historyLimitsLabel.text = Localized.historyLimitsTitle
    }
    
    private func setupLanguage() {
        let userDefault = UserDefaults.standard
        guard let language = userDefault.object(forKey: Constans.languageKEY) as? String else {return}
        guard let object = Language(rawValue: language.lowercased()) else {return}
        for (index, element) in languageCollectionView.enumerated() {
            let tap = UITapGestureRecognizer(target: self, action: #selector(handleLanguageViewTap(sender:)))
            languageCollectionView[index].addGestureRecognizer(tap)
            languageCollectionView[index].isUserInteractionEnabled = true
            if index == object.position {
                languageCollectionView[index].backgroundColor = .lightGray
            } else {
                languageCollectionView[index].backgroundColor = .white
            }
            // Label's Text
            if let label = element.subviews[0] as? UILabel {
                switch index {
                case 0:
                    label.text = Localized.es
                case 1:
                    label.text = Localized.en
                case 2:
                    label.text = Localized.it
                case 3:
                    label.text = Localized.de
                default:
                    break
                }
            }
        }
    }
    
    private func setupPicker() {
        historyLimitsPickerView.delegate = self
        historyLimitsPickerView.dataSource = self
        let selectedRow = retrieveHistoryMaxElements()
        var row = 0
        switch selectedRow {
        case 5:
            row = 0
        case 10:
            row = 1
        case 999:
            row = 2
        default:
            break
        }
        historyLimitsPickerView.selectRow(row, inComponent: 0, animated: true)        
    }
    
    private func setupTable() {
        historyTableView.delegate = self
        historyTableView.dataSource = self
        let tabsNib = UINib(nibName: "HistoryTableViewCell", bundle: nil)
        historyTableView.register(tabsNib, forCellReuseIdentifier: "HistoryTableViewCell")
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
        if let data = data, !data.isEmpty {            
            ErrorHandler.showAlert(title: Localized.historyDelete, msg: Localized.safeDelete, actionButtonTitle: Localized.accept, action: {
                self.eraseData()
                self.data = nil
                self.historyTableView.reloadData()
                }, dismissButtonTitle: Localized.cancel, dismissAction: nil)
        }
    }
    
    @IBAction func switchAction(_ sender: UISwitch) {
        saveStateCollapsibleElements(state: sender.isOn)
    }
    
    // MARK: - CoreData
    
    private func retrieveHistory() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = appDelegate.persistenContainer.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "History")
        do {
            guard let result = try context.fetch(fetchRequest) as? [NSManagedObject] else {return}
            var elements = [HistoryDataModel]()
            for data in result {
                let number = data.value(forKey: "number") as? String ?? ""
                let date = data.value(forKey: "date") as? String ?? ""
                let language = data.value(forKey: "language") as? String ?? ""
                let object = HistoryDataModel(number: number, date: date, language: language)
                elements.append(object)
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
    
    private func deleteElement(at position: Int) -> Bool {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate,
        let data = data else {return false}        
        let context = appDelegate.persistenContainer.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "History")
        fetchRequest.predicate = NSPredicate(format: "number == %@", data[position].number)
        do {
            guard let elements = try context.fetch(fetchRequest) as? [NSManagedObject] else {return false}
            if elements.count != 1 {
                return false
            }
            for element in elements {
                context.delete(element)
            }
            do {
                try context.save()
                return true
            } catch let error {
                ErrorHandler.showError(error: error)
            }
        } catch let error {
            ErrorHandler.showError(error: error)
        }
        return false
    }
    
    // MARK: - UserDefault
    
    private func retrieveCollapsibleElements() -> Bool {
        let userDefault = UserDefaults.standard
        return userDefault.object(forKey: Constans.collapsedElements) as? Bool ?? false
    }
    
    private func saveStateCollapsibleElements(state: Bool) {
        let userDefault = UserDefaults.standard
        userDefault.set(state, forKey: Constans.collapsedElements)
    }
    
    private func saveHistoryMaxElements(limit: Int) {
        let userDefault = UserDefaults.standard
        userDefault.set(limit, forKey: Constans.historyKEY)
    }
    
    private func retrieveHistoryMaxElements() -> Int {
        let userDefault = UserDefaults.standard
        return userDefault.object(forKey: Constans.historyKEY) as? Int ?? 5
    }
    
}

// MARK: - TableView

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let elements = data?.count {
            return elements
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryTableViewCell") as? HistoryTableViewCell else {return UITableViewCell()}
        if let data = data {
            let element = data[indexPath.row]
            cell.display(number: element.number, language: element.language.uppercased(), date: element.date)            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let data = data {
            delegate?.didSelectHistory(number: data[indexPath.row].number)
            dismiss(animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if deleteElement(at: indexPath.row) {
                data?.remove(at: indexPath.row)
                tableView.beginUpdates()
                tableView.deleteRows(at: [indexPath], with: .automatic)
                tableView.endUpdates()
            }
        }
    }
}

// MARK: - UIPickerViewDelegate & UIPickerViewDataSource

extension SettingsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch row {
        case 0:
            return "5"
        case 1:
            return "10"
        case 2:
            return "∞"
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch row {
        case 0:
            saveHistoryMaxElements(limit: 5)
        case 1:
            saveHistoryMaxElements(limit: 10)
        case 2:
            saveHistoryMaxElements(limit: 999)
        default:
            break
        }
    }
}
