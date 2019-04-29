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
}

class MainTableViewCell: UITableViewCell {

    @IBOutlet private var settingsIcon: UIImageView!
    @IBOutlet private var searchBar: UISearchBar!
    
    var delegate: MainTableViewCellProtocol?
    
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
}
