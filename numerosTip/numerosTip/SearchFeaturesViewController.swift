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
    
    fileprivate var kCellWidth = 120
    fileprivate var kCellHeight = 80
        
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
        
        let flow = collectionView.collectionViewLayout as? UICollectionViewFlowLayout

        let width = UIScreen.main.bounds.size.width - 5 * CGFloat(2 - 1)
        flow?.itemSize = CGSize(width: floor(width/2), height: width/2)
        flow?.minimumInteritemSpacing = 3
        flow?.minimumLineSpacing = 3
    }
    
    private func setupNavigationBar() {
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
    }
    
}

extension SearchFeaturesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//
//        var insets = UIEdgeInsets()
//
//        if case UIDevice.current.screenType.rawValue  = UIDevice.ScreenType.iPhones_5_5s_5c_SE.rawValue {
//            insets = UIEdgeInsets(top: 10, left: 15, bottom: 5, right: 15)
//        } else {
//            insets = UIEdgeInsets(top: 10, left: 15, bottom: 5, right: 15)
//        }
//
//        return insets
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: kCellWidth, height: kCellHeight)
    }
    
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
