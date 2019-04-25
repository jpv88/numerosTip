//
//  TabsTableViewCell.swift
//  numerosTip
//
//  Created by Jared Perez Vega on 25/04/2019.
//  Copyright © 2019 Jared Perez Vega. All rights reserved.
//

import UIKit

class TabsTableViewCell: UITableViewCell {

    @IBOutlet var informationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        informationLabel.backgroundColor = UIColor(rgb: 0x97D6F7)
        informationLabel.textColor = UIColor.white
        informationLabel.layer.masksToBounds = true
        informationLabel.layer.cornerRadius = 20
    }
    
    func displayContent(input: String) {
        informationLabel.text = input
    }
}
