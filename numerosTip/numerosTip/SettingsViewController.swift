//
//  SettingsViewController.swift
//  numerosTip
//
//  Created by Jared Perez Vega on 02/05/2019.
//  Copyright © 2019 Jared Perez Vega. All rights reserved.
//

import UIKit

enum Language: String {
    case es
    case en
    case it
    case al
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
            self = Language.al
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
        case .al:
            return 3
        }
    }
}

class SettingsViewController: UIViewController {
    
    // 0 -> ES, 1 -> EN, 2 -> IT, 3 -> AL
    @IBOutlet var languageCollectionView: Array<UIView>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLanguage()
    }
    
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
    
    @objc private func handleLanguageViewTap(sender: UITapGestureRecognizer) {
        guard let viewTag = sender.view?.tag else {return}
        let language = Language(position: viewTag)
        let userDefault = UserDefaults.standard
        userDefault.set(language.rawValue, forKey: Constans.languageKEY)
        setupLanguage()
    }
    
    @IBAction func closeSettings(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }    

}
