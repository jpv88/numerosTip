//
//  SectionCollapsible.swift
//  numerosTip
//
//  Created by Jared Perez Vega on 30/4/18.
//  Copyright © 2018 Jared Perez Vega. All rights reserved.
//

import UIKit

protocol SectionCollapsibleProtocol {
    func headerTapped(section: Int)
}

final class SectionCollapsible: UIView {
    var delegate: SectionCollapsibleProtocol?
    
    @IBOutlet weak var sectionImage: UIImageView!
    @IBOutlet var view: UIView!
    @IBOutlet weak var sectionTitle: UILabel!
    private var sectionNumber: Int!
    
    convenience init(section: Int){
        self.init()
        self.sectionNumber = section
    }
    
    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit() {
        let view = Bundle.main.loadNibNamed("SectionCollapsible", owner: self, options: nil)![0] as! UIView
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        view.addGestureRecognizer(tap)
        view.isUserInteractionEnabled = true
        self.addSubview(view)
        view.frame = self.bounds
    }

    func handleTap(_ sender: UITapGestureRecognizer) {
        delegate?.headerTapped(section: self.sectionNumber)
    }
}
