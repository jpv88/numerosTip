//
//  ErrorDataModel.swift
//  numerosTip
//
//  Created by Jared Perez Vega on 15/05/2019.
//  Copyright © 2019 Jared Perez Vega. All rights reserved.
//

import UIKit
import SwiftyJSON

class ErrorDataModel: NSObject {
    
    private var titleKeysOptions = ["#","&&", "&"]
    private var totalElements : Int = 0
    var sections: [Section] = []
    
    init(data: JSON) {
        super.init()
        let arrayTotal = data["d"].arrayValue
        let arrayData = arrayTotal[0].arrayValue
        totalElements = arrayData.count
        var customSections: [Section] = []
        var section: Section?
        for (_,element) in arrayData.enumerated() {

            let element = element.rawString() ?? ""
            
            if isTitle(str: element) {
                if let sec = section {
                    customSections.append(sec)
                    section = nil
                    section = Section()
                    section?.title =  element
                } else {
                    section = Section()
                    section?.title =  element
                }
            } else {
//                if var sec = section {
                    section?.content.append(element)
//                }
            }
        }
        if let sec = section {
            customSections.append(sec)
        }
        self.sections = customSections
    }
    
    struct Section {
        var title: String?
        var content: [String] = []
    }
    
    private func isTitle(str: String) -> Bool {
        for key in titleKeysOptions {
            if str.prefix(2).contains(key) {
                return true
            }
        }
        return false
    }
}
