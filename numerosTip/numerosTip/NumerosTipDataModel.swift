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
        var identifierText: String?
        init(initialArray: NSMutableArray) {
            number = initialArray[0] as? String
            identifierText = initialArray[1] as? String
        }
    }
    
    struct TabsModel {
        var title: String?
        var descriptiveTitleText: String?
        var subtitle: String?
        var descriptiveSubitleText: String?
        var allOptions: [String] = []
        
        init(array: NSMutableArray){
            for (index, element) in array.enumerated() {
                switch index {
                case 0:
                    title = element as? String
                    break
                case 1:
                    descriptiveTitleText = element as? String
                    break
                case 2:
                    subtitle = element as? String
                    break
                case 3:
                    descriptiveSubitleText = element as? String
                    break
                default:
                    allOptions.append(element as! String)
                    break
                }
            }
        }
        
        func getSize() -> Int {
            return allOptions.count + 3
        }
        
    }
    
    
}
