//
//  NumerosTipDataModel.swift
//  numerosTip
//
//  Created by Jared Perez Vega on 29/8/17.
//  Copyright © 2017 Jared Perez Vega. All rights reserved.
//

import UIKit
import SwiftyJSON

class NumerosTipDataModel: NSObject {
    
    private static var titleKeysAllOptions = ["#","&&", "&"]
    private static var titleKeys = ["&&", "&"]
    private static var flagTitlesInSection = false
    var totalElements : Int = 0
    var initialView: InitialView?
    var tabsArray: [TabsModel] = []
    
    
    init(data: JSON) {
        let arrayData = data["d"].arrayValue
        self.totalElements = arrayData.count - 1
        for (index,element) in arrayData.enumerated() {
            let array: NSMutableArray = []            
            for (x, _) in element.enumerated(){
                print("iteracion: \(x)")
                print(element[x].rawValue)
                array.add(element[x].rawValue as! String)
            }
            // Index arrayData Case
            if (index == 0) {
                self.initialView = InitialView(initialArray: array)
            } else {
                let object = TabsModel(array: array)
                self.tabsArray.append(object)
            }
        }
    }
    
    struct InitialView {
        var number: String?
        var descriptionText: String?
        init(initialArray: NSMutableArray) {
            number = initialArray[0] as? String
            descriptionText = initialArray[1] as? String
        }
    }
    
    struct TabsModel {
        var title: String?
        var description: String?
        var sections = [SectionModel]()
        init(array: NSMutableArray){
            var section: SectionModel?
            for (index, element) in array.enumerated() {
                guard let element = element as? String else { return }
                switch index {
                case 0:
                    title = element
                    break
                case 1:
                    description = element
                    break
                default:
                    if isTitle(str: element) {
                        if let section = section {
                            sections.append(section)
                        }
                        section = SectionModel()
                        section?.title = element
                    } else {
                        section?.data.append(element)
                    }
                    let lastObject = array.lastObject as? String
                    if (lastObject == element) {
                        if let section = section {
                            sections.append(section)
                            flagTitlesInSection = false
                        }
                    }
                    break
                }
            }
        }
        
        private func isTitle(str: String) -> Bool {
            var dictionary: [String]
            if !flagTitlesInSection {
                dictionary = titleKeysAllOptions
            } else {
                dictionary = titleKeys
            }
            if str.contains("&&") {
                 flagTitlesInSection = true
            }
            for key in dictionary {
                if str.contains(key) {
                    return true
                }
            }
            return false
        }
        
        func getSectionNumber() -> Int {
            return 1
        }
        
    }
    
    struct SectionModel {
        var title: String?
        var data = [String]()
    }
    
}
