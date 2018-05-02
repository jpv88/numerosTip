//
//  SearchResultsViewController.swift
//  numerosTip
//
//  Created by Jared Perez Vega on 22/4/18.
//  Copyright © 2018 Jared Perez Vega. All rights reserved.
//

import UIKit

class SearchResultsViewController: UIViewController {
    
    var data: NumerosTipDataModel.TabsModel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupTableView()
    }
    
    private func setupNavigationBar() {
        // Design
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
        // Title
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = titleDict as? [String : Any]
        navigationController?.navigationBar.topItem?.title = "Resultados"
        //        navigationController?.navigationBar.topItem?.hidesBackButton = true
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.bounces = false
        let nib = UINib(nibName: "TableViewDynamicCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "TableViewDynamicCell")
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableViewAutomaticDimension
    }

}

extension SearchResultsViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func cleanString(str: String) -> String {
        var cleanedString = str
        
        cleanedString = cleanedString.replacingOccurrences(of: "&", with: "")
        cleanedString = cleanedString.replacingOccurrences(of: "&&", with: "")
        cleanedString = cleanedString.replacingOccurrences(of: "#", with: "")
        
        return cleanedString
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = SectionCollapsible(section: section)
//        label.autoresizingMask = [.flexibleWidth, .flexibleHeight, .flexibleTopMargin, .flexibleBottomMargin, .flexibleLeftMargin, .flexibleRightMargin]
        label.delegate = self
        label.view.backgroundColor = UIColor.lightGray
        label.sectionImage.image = UIImage(named: "chevron-right")
        if data.sections[section].expanded {
            label.sectionImage.transform = label.sectionImage.transform.rotated(by: CGFloat.pi/2)
        }        
        if let title = data.sections[section].title {
            label.sectionTitle.text = cleanString(str: title)
        }
        return label
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return data.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if data.sections[section].expanded {
            return data.sections[section].data.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewDynamicCell") as? TableViewDynamicCell else { return UITableViewCell() }
        cell.information.attributedText = data.sections[indexPath.section].data[indexPath.row].html2AttributedString
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("click..")
    }
}

extension SearchResultsViewController: SectionCollapsibleProtocol {
    func headerTapped(section: Int) {
        print("Tapped Header Sectionat at:\(section)")
        data.sections[section].expanded = !data.sections[section].expanded
//        tableView.reloadData()
        UIView.transition(with: tableView,
                          duration: 0.01,
                          options: .transitionCrossDissolve,
                          animations: { self.tableView.reloadData() })
//        let index = IndexSet(integer: section)
//        tableView.reloadSections(index, with: UITableViewRowAnimation.none)
    }
    
    
}
