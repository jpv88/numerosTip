//
//  SearchFeaturesViewController.swift
//  numerosTip
//
//  Created by Jared Perez Vega on 11/4/18.
//  Copyright © 2018 Jared Perez Vega. All rights reserved.
//

import UIKit

class SearchFeaturesViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    fileprivate var data = ["Pepe", "Juan","Pepe", "Juan","Pepe", "Juan","Pepe", "Juan","Pepe", "Juan","Pepe", "Juan","Pepe", "Juan","Pepe", "Juan","Pepe", "Juan","Pepe", "Juan","Pepe", "Juan","Pepe", "Juan","Pepe", "Juan","Pepe", "Juan", "Antonio"]
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupNavigationBar()
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib.init(nibName: "SearchCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SearchCollectionViewCell")
        collectionView.bounces = false
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: collectionView.frame.width/4, height: 80)
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        collectionView.collectionViewLayout = layout
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
    
}

extension SearchFeaturesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
        
        cell.displayContent(input: data[indexPath.row])
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(data[indexPath.row])
    }

}
