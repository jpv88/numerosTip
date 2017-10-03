//
//  NumerosTipLanguageCollectionDataSource.swift
//  numerosTip
//
//  Created by Jared Perez Vega on 3/10/17.
//  Copyright © 2017 Jared Perez Vega. All rights reserved.
//

import UIKit

struct LanguageModel {
    var language: String?
    var isSelected: Bool?
    init(lng: String, selected: Bool = false) {
        language = lng
        isSelected = selected
    }
    
}

class NumerosTipLanguageCollectionDataSource: NSObject, UICollectionViewDataSource {
    
    let numberOfSections = 1
    let numberOfLanguages = 4
    
    var data: [LanguageModel] = []
    
    override init() {
        for index in 1...4 {
            var lng: LanguageModel
            switch index {
            case 0:
                // Spain Case
                lng = LanguageModel(lng: "ES", selected: true)
                break
            case 1:
                // English Case
                lng = LanguageModel(lng: "EN")
                break
            case 2:
                // Italy Case
                lng = LanguageModel(lng: "IT")
                break
            case 3:
                // Germany Case
                lng = LanguageModel(lng: "GE")
                break
            default:
                lng = LanguageModel(lng: "EN")
                break
            }
                data.append(lng)
        }
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int{
        return numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NumerosTipLanguageCell", for: indexPath) as! NumerosTipLanguageCell
        
        switch indexPath.row {
            case 0:
                cell.imageView.image = #imageLiteral(resourceName: "Spain")                
                break
            default:
                break
        }
        
        
        return cell
    }                
}
