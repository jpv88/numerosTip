//
//  ErrorDetailViewController.swift
//  numerosTip
//
//  Created by Jared Perez Vega on 15/05/2019.
//  Copyright © 2019 Jared Perez Vega. All rights reserved.
//

import UIKit

class ErrorDetailViewController: UIViewController {

    @IBOutlet private var tableView: UITableView!
    var data: ErrorDataModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        setupTableView()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewTapped(tapGestureRecognizer:)))
//        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @IBAction func acceptButton(_ sender: UIButton) {
        closeScreen()
    }
    
    @objc private func viewTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        closeScreen()
    }
    
    private func closeScreen() {
        dismiss(animated: true, completion: nil)
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: "TableViewDynamicCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "TableViewDynamicCell")
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.sectionHeaderHeight = UITableViewAutomaticDimension;
        tableView.estimatedSectionHeaderHeight = 25;
        tableView.tableFooterView = UIView()
    }
}

extension ErrorDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func cleanString(str: String) -> String {
        var cleanedString = str
        
        cleanedString = cleanedString.replacingOccurrences(of: "&", with: "")
        cleanedString = cleanedString.replacingOccurrences(of: "&&", with: "")
        cleanedString = cleanedString.replacingOccurrences(of: "#", with: "")
        
        return cleanedString
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.numberOfLines = 0
        label.backgroundColor = .yellow
        if let title = data?.sections[section].title {
            label.text = cleanString(str: title)
        }
        return label
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let elements = data?.sections {
            return elements.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let element = data?.sections[section] {
            return element.content.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewDynamicCell") as? TableViewDynamicCell else { return UITableViewCell() }
        if let element = data?.sections[indexPath.section] {
            let str = element.content[indexPath.row]
            cell.information.attributedText = str.html2AttributedString
        }
        return cell
    }
    
}
