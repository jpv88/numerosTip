//
//  HistoryTableViewCell.swift
//  numerosTip
//
//  Created by Jared Perez Vega on 27/05/2019.
//  Copyright © 2019 Jared Perez Vega. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    @IBOutlet private var cardView: UIView!
    @IBOutlet private var numberValueLabel: UILabel!
    @IBOutlet private var languageValueLabel: UILabel!
    @IBOutlet private var languageTitleLabel: UILabel!
    @IBOutlet private var dateValueLabel: UILabel!
    @IBOutlet private var numberTitleLabel: UILabel!
    @IBOutlet private var dateTitleLabel: UILabel!
    
    private enum Localizable {
        static let date = "settings_history_date".localized()
        static let number = "settings_history_number".localized()
        static let language = "settings_history_language".localized()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        self.backgroundColor = .clear
        cardView.backgroundColor = .lightGray
        cardView.layer.masksToBounds = true
        cardView.layer.cornerRadius = 20
        // Labels Title
        dateTitleLabel.text = Localizable.date
        numberTitleLabel.text = Localizable.number
        languageTitleLabel.text = Localizable.language
    }
    
    func display(number: String, language: String, date: String) {
        numberValueLabel.text = number
        languageValueLabel.text = language
        dateValueLabel.text = date
    }
}
