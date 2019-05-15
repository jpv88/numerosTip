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
    
    func getDataFromWebService(viewController: UIViewController, number: String, completionHandler: @escaping (NumerosTipDataModel, ErrorDataModel?) -> Void, serviceError: @escaping (Error) -> Void) {
        Network.requestWebService(reference: viewController, number: number, completionHandler: { response, errorResponse  in
            completionHandler(response, errorResponse)
        }) { error in
            serviceError(error)
        }
    }
}
