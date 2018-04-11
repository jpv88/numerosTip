//
//  SearchCollectionViewCell.swift
//  numerosTip
//
//  Created by Jared Perez Vega on 11/4/18.
//  Copyright © 2018 Jared Perez Vega. All rights reserved.
//

import UIKit

class SearchCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var information: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    private func setupUI() {
        backgroundColor = UIColor(rgb: 0x97D6F7)
        information.tintColor = UIColor.white
    }
    
    func displayContent(input: String) {
        information.text = input
    }

}
