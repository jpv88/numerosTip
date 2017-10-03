//
//  NumerosTipLanguageCollectionDelegate.swift
//  numerosTip
//
//  Created by Jared Perez Vega on 3/10/17.
//  Copyright © 2017 Jared Perez Vega. All rights reserved.
//

import UIKit

class NumerosTipLanguageCollectionDelegate: NSObject, UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        print("estas pulsando la posicion: \(indexPath.row)")
    }
}

