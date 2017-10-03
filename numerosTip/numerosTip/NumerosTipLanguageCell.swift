//
//  NumerosTipLanguageCell.swift
//  numerosTip
//
//  Created by Jared Perez Vega on 3/10/17.
//  Copyright © 2017 Jared Perez Vega. All rights reserved.
//

import UIKit

class NumerosTipLanguageCell: UICollectionViewCell {

    @IBOutlet weak var drawLineLayout: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        imageView.image = #imageLiteral(resourceName: "Germany")
        drawLineLayout.backgroundColor = .black
    }

}
