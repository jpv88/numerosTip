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
    
    var delegate: MainTableViewCellProtocol?
    
    private enum Localized {
        static let title = "global_position_title".localized()
        static let subtitle = ""
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
        
        titleLabel.text = Localized.title
    }
    
    @objc private func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        delegate?.settingsIconTapped()
    }
    
}

extension MainTableViewCell: UISearchBarDelegate {
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
