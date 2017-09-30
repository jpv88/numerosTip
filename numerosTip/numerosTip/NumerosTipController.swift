//
//  NumerosTipController.swift
//  numerosTip
//
//  Created by Jared Perez Vega on 30/9/17.
//  Copyright © 2017 Jared Perez Vega. All rights reserved.
//

import UIKit

class NumerosTipController {
    
    static let sharedInstance = NumerosTipController()
    
    private init() {}
    
    func llamadaServicioWeb(viewController: UIViewController, completionHandler: @escaping (NumerosTipDataModel) -> Void) {
        Network.requestWebService(reference: viewController) {
            response in
            completionHandler(response)
        }
    }
}
