//
//  CollapsibleTableViewHeader.swift
//  numerosTip
//
//  Created by Jared Perez Vega on 22/05/2019.
//  Copyright © 2019 Jared Perez Vega. All rights reserved.
//

import UIKit

protocol CollapsibleTableViewHeaderDelegate {
    func toggleSection(_ header: CollapsibleTableViewHeader, section: Int)
}

class CollapsibleTableViewHeader: UITableViewHeaderFooterView {
    
    let titleLabel = UILabel()
    let arrowImageView = UIImageView()
    
    var delegate: CollapsibleTableViewHeaderDelegate?
    var section: Int = 0
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        titleLabel.numberOfLines = 0
        contentView.backgroundColor = .yellow
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapHeader(_:))))
        
        let marginGuide = contentView.layoutMarginsGuide
        
        contentView.addSubview(arrowImageView)
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        arrowImageView.widthAnchor.constraint(equalToConstant: 12).isActive = true
        arrowImageView.heightAnchor.constraint(equalToConstant: 12).isActive = true
        arrowImageView.topAnchor.constraint(equalTo: marginGuide.topAnchor, constant: 5).isActive = true
        arrowImageView.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor, constant: 5).isActive = true
        
        contentView.addSubview(titleLabel)
        titleLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor, constant: 5)
        titleLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor, constant: 5)
        titleLabel.trailingAnchor.constraint(equalTo: arrowImageView.leadingAnchor, constant: 5)
        titleLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor, constant: 5)
    }
    
    @objc private func tapHeader(_ gestureRecognizer: UITapGestureRecognizer) {
        guard let cell = gestureRecognizer.view as? CollapsibleTableViewHeader else {
            return
        }
        delegate?.toggleSection(self, section: cell.section)
    }
    
    private func setCollapsed(_ collapsed: Bool) {
        // Animate the arrow rotation (see Extensions.swf)
        //        arrowLabel.rotate(collapsed ? 0.0 : .pi / 2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
