//
//  SearchFeaturesViewController.swift
//  numerosTip
//
//  Created by Jared Perez Vega on 11/4/18.
//  Copyright © 2018 Jared Perez Vega. All rights reserved.
//

import UIKit

class SearchFeaturesViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    fileprivate var data = ["Pepe", "Juan","Pepe", "Juan","Pepe", "Juan","Pepe", "Juan","Pepe", "Juan","Pepe", "Juan","Pepe", "Juan","Pepe", "Juan","Pepe", "Juan","Pepe", "Juan","Pepe", "Juan","Pepe", "Juan","Pepe", "Juan","Pepe", "Juan", "Antonio"]
    
    var dataNew: NumerosTipDataModel!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupTitleLabel()
        setupCollectionView()
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
    
    private func setupTitleLabel() {
        titleLabel.backgroundColor = UIColor(rgb: 0x1A7A9F)
        titleLabel.text = dataNew.initialView?.descriptionText
        titleLabel.textColor = UIColor.white
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib.init(nibName: "SearchCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SearchCollectionViewCell")
        collectionView.bounces = false
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets.zero
        layout.itemSize = CGSize(width: collectionView.frame.width/3, height: 80)
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        collectionView.collectionViewLayout = layout
    }
}

extension SearchFeaturesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataNew.tabsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
        
        if let title = dataNew.tabsArray[indexPath.row].title {
            cell.displayContent(input: title)
        }        
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let title = dataNew.tabsArray[indexPath.row].title {
            print(title)
        }
    }

}
