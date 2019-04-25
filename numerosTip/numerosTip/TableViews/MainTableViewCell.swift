//
//  MainTableViewCell.swift
//  numerosTip
//
//  Created by Jared Perez Vega on 24/04/2019.
//  Copyright © 2019 Jared Perez Vega. All rights reserved.
//

import UIKit

protocol SearcherTextProtocol {
    func searchFieldDidReturn(_ text: String)
}

class MainTableViewCell: UITableViewCell {

    @IBOutlet var searchBar: UISearchBar!
    
    var delegate: SearcherTextProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
        searchBar.delegate = self
    }  
    
}

extension MainTableViewCell: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)        
        guard let text = searchBar.text, !text.isEmpty else {return}
        delegate?.searchFieldDidReturn(text)
    }
}
