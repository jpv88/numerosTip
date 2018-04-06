//
//  LanguageTableViewController.swift
//  numerosTip
//
//  Created by Jared Perez Vega on 6/4/18.
//  Copyright © 2018 Jared Perez Vega. All rights reserved.
//

import UIKit

class LanguageTableViewController: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var data: [LanguagesDisponibility]!
    
    convenience init(data: [LanguagesDisponibility]) {
        self.init()
        
        self.data = data
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = data[indexPath.row].getLanguage()
        cell.textLabel?.textColor = UIColor.white
        cell.backgroundColor = data[indexPath.row].getColor()
        let disclosureImage = UIImage(named: "chevron-right")
        let disclosureView = UIImageView(image: disclosureImage)
        disclosureView.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        disclosureView.tintColor = UIColor.white
        cell.accessoryView = disclosureView
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("click..")
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}
