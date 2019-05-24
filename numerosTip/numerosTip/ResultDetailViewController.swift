//
//  ResultDetailViewController.swift
//  numerosTip
//
//  Created by Jared Perez Vega on 26/04/2019.
//  Copyright © 2019 Jared Perez Vega. All rights reserved.
//

import UIKit

class ResultDetailViewController: UIViewController {
    
    @IBOutlet private var navBarDetail: UINavigationItem!
    @IBOutlet private var tableView: UITableView!
    
    var data: NumerosTipDataModel.TabsModel!
    
    private var collapsedElements: Bool?
    private var collapsibleElements: [Int] = []
    
    private enum Localizables {
        static let navBarTitle = "results_navBar_title".localized()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navBarDetail.title = Localizables.navBarTitle
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        recoverUserSettings()
        setupTableView()
    }
    
    private func recoverUserSettings() {
        let userDefault = UserDefaults.standard
        collapsedElements = userDefault.object(forKey: Constans.collapsedElements) as? Bool ?? false        
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: "TableViewDynamicCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "TableViewDynamicCell")
        tableView.register(CollapsibleTableViewHeader.self, forHeaderFooterViewReuseIdentifier: "CollapsibleTableViewHeader")
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.sectionHeaderHeight = UITableViewAutomaticDimension
        tableView.estimatedSectionHeaderHeight = 25
        tableView.tableFooterView = UIView()
    }
    
}

extension ResultDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func cleanString(str: String) -> String {
        var cleanedString = str
        
        cleanedString = cleanedString.replacingOccurrences(of: "&", with: "")
        cleanedString = cleanedString.replacingOccurrences(of: "&&", with: "")
        cleanedString = cleanedString.replacingOccurrences(of: "#", with: "")
        
        return cleanedString
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CollapsibleTableViewHeader") as? CollapsibleTableViewHeader
        if let title = data.sections[section].title {
            header?.titleLabel.text = cleanString(str: title)
            if title.prefix(2).components(separatedBy: "&").count == 2 {
                header?.arrowLabel.text = ">"
                header?.setCollapsed(data.sections[section].collapsed)
            }
        }
        header?.section = section
        header?.delegate = self
        
        if let header = header {
            let separatorLine = UIView()
            separatorLine.backgroundColor = .lightGray
            header.addSubview(separatorLine)
            separatorLine.translatesAutoresizingMaskIntoConstraints = false
            separatorLine.leadingAnchor.constraint(equalTo: header.leadingAnchor).isActive = true
            separatorLine.trailingAnchor.constraint(equalTo: header.trailingAnchor).isActive = true
            separatorLine.bottomAnchor.constraint(equalTo: header.bottomAnchor).isActive = true
            separatorLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        }
        
        return header
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.sections[section].collapsed ?? false ? 0 : data.sections[section].data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewDynamicCell") as? TableViewDynamicCell else { return UITableViewCell() }
        cell.information.attributedText = data.sections[indexPath.section].data[indexPath.row].html2AttributedString
        return cell
    }
    
}

extension ResultDetailViewController: CollapsibleTableViewHeaderDelegate {
    func toggleSection(_ header: CollapsibleTableViewHeader, section: Int) {
        if let title = data.sections[section].title {
            if title.prefix(2).components(separatedBy: "&").count == 2 {
                let collapsed = !data.sections[section].collapsed
                // Toggle collapse
                data.sections[section].collapsed = collapsed
                header.setCollapsed(collapsed)
                // Reload Animation
                tableView.reloadSections(NSIndexSet(index: section) as IndexSet, with: .automatic)
            }
        }
    }
    
}
