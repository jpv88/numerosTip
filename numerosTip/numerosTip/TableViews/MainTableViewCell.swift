//
//  MainTableViewCell.swift
//  numerosTip
//
//  Created by Jared Perez Vega on 24/04/2019.
//  Copyright © 2019 Jared Perez Vega. All rights reserved.
//

import UIKit

protocol MainTableViewCellProtocol {
    func searchFieldDidReturn(_ text: String)
    func settingsIconTapped()
    func clearResults()
}

class MainTableViewCell: UITableViewCell {

    @IBOutlet private var settingsIcon: UIImageView!
    @IBOutlet private var searchBar: UISearchBar!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var subtitleLabel: UILabel!
    
    private let integerKeyboard = Bundle.main.loadNibNamed("IntegerKeyboard", owner: self, options: nil)?.last as! IntegerKeyboard
    
    var delegate: MainTableViewCellProtocol?
    
    private enum Localized {
        static let title = "global_position_title".localized()
        static let subtitle = "global_position_subtitle".localized()
        static let searchBar = "global_position_searchBar".localized()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
        searchBar.delegate = self
        settingsIcon.image = settingsIcon.image?.withRenderingMode(.alwaysTemplate)
        settingsIcon.tintColor = .white
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        settingsIcon.isUserInteractionEnabled = true
        settingsIcon.addGestureRecognizer(tapGestureRecognizer)
        let textFieldInsideUISearchBar = searchBar.value(forKey: "searchField") as? UITextField
        let placeholderLabel = textFieldInsideUISearchBar?.value(forKey: "placeholderLabel") as? UILabel
        placeholderLabel?.adjustsFontSizeToFitWidth = true
        placeholderLabel?.minimumScaleFactor = 0.6
        searchBar.placeholder = Localized.searchBar
        let searchTextField = searchBar.value(forKey: "_searchField") as? UITextField
        searchTextField?.inputView = integerKeyboard
        integerKeyboard.delegate = self
    }
    
    @objc private func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        delegate?.settingsIconTapped()
    }
    
}

extension MainTableViewCell: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        let searchTextField = searchBar.value(forKey: "_searchField") as? UITextField
        (searchTextField?.inputView as? IntegerKeyboard)?.target = searchTextField
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        guard let text = searchBar.text, !text.isEmpty else {return}
        delegate?.searchFieldDidReturn(text)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            delegate?.clearResults()
        }
    }
}

extension MainTableViewCell: SearchResultsSearchBarProtocol {
    func setterSearchBar(number: String) {
        searchBar.text = number        
    }
}

extension MainTableViewCell: CustomKeyboardProtocol {
    func changeToRomanKeyboard() {
        
    }
    
    func search() {
        searchBar.endEditing(true)
        guard let text = searchBar.text, !text.isEmpty else {return}
        delegate?.searchFieldDidReturn(text)
    }
    
    func changeToIntegerKeyboard() {
        
    }
    
}
