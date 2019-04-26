//
//  GlobalPositionTableViewController.swift
//  numerosTip
//
//  Created by Jared Perez Vega on 24/04/2019.
//  Copyright © 2019 Jared Perez Vega. All rights reserved.
//

import UIKit

class GlobalPositionTableViewController: UITableViewController {
    
    private var controller: NumerosTipController?
    
    private var data: NumerosTipDataModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        controller = NumerosTipController.sharedInstance
        setGradientBackground()
        setupTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @objc private func handleTap(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    private func setupTable(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tapGesture.cancelsTouchesInView = false
        tableView.addGestureRecognizer(tapGesture)
        tableView.delegate = self
        tableView.dataSource = self
        let mainNib = UINib(nibName: "MainTableViewCell", bundle: nil)
        let tabsNib = UINib(nibName: "TabsTableViewCell", bundle: nil)
        tableView.register(mainNib, forCellReuseIdentifier: "MainTableViewCell")
        tableView.register(tabsNib, forCellReuseIdentifier: "TabsTableViewCell")
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
    }
    
    private func setGradientBackground() {
        let leftColor = UIColor(rgb: 0x0C77B8)
        let rightColor = UIColor(rgb: 0x0C3B5D)
        let gradientBackgroundColors = [leftColor.cgColor, rightColor.cgColor]
        let gradientLocations = [0.0, 1.0]
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientBackgroundColors
        gradientLayer.locations = gradientLocations as [NSNumber]
        gradientLayer.startPoint = CGPoint(x: 0, y: 1)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = self.tableView.bounds
        let backgroundView = UIView(frame: self.tableView.bounds)
        backgroundView.layer.insertSublayer(gradientLayer, at: 0)
        self.tableView.backgroundView = backgroundView
    }
    
    private func isRomanNumber(text: String) -> Bool {
        let patttern = "^(?=[MDCLXVI])M*(C[MD]|D?C{0,3})(X[CL]|L?X{0,3})(I[XV]|V?I{0,3})$"
        let regex = try? NSRegularExpression(pattern: patttern, options: [.caseInsensitive])
        guard let matches = regex?.matches(in: text, options: [], range: NSRange(location: 0, length: text.count)) else {return false}
        if matches.isEmpty {
            return false
        }
        return true
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 420
        default:
            return 60
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let elements = data?.tabsArray {
            return elements.count + 1
        }
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
            cell.delegate = self
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TabsTableViewCell", for: indexPath) as? TabsTableViewCell else { return UITableViewCell() }
            if let title = data?.tabsArray[indexPath.row - 1].title {
                var titleCleaned = title
                if titleCleaned.contains("#") {
                    titleCleaned = titleCleaned.replacingOccurrences(of: "#", with: "")
                }
                cell.displayContent(input: titleCleaned)
            }
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            break
        default:                        
            break
        }
    }
    
    // MARK: - API
    
    func getNumberTIP(number: String) {
        controller?.getDataFromWebService(viewController: self, number: number, completionHandler: { response in
            self.data = response
            self.tableView.reloadData()
//            if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "SearchFeaturesViewController"), let vc = viewController as? SearchFeaturesViewController {
//                vc.data = response
//                self.navigationController?.pushViewController(viewController, animated: true)
//            }
        }, serviceError: { error in
            // TODO
            print("error")
        })
    }
}

extension GlobalPositionTableViewController: SearcherTextProtocol {
    func searchFieldDidReturn(_ text: String) {
        let number = Int(text)
        if number != nil || isRomanNumber(text: text) == true {
            // TODO
            // Save search history
            //            history.save(text)
            getNumberTIP(number: text)
        } else {
            // TODO
            print("Lanzar error: asegúrate estás introduciendo el número correctamente")
        }
    }
}
