//
//  Network.swift
//  numerosTip
//
//  Created by Jared Perez Vega on 22/8/17.
//  Copyright © 2017 Jared Perez Vega. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class Network: NSObject {
    
    
    
    class func requestWebService() {
    
        let url = "http://tip.dis.ulpgc.es/ServicioNumeros/Numeros.asmx/ConvierteNumero"
        let inputJson: [String : Any] = ["numeroText":13,
                                         "lang":"es"]
        
        Alamofire.request(url, method: .post, parameters: inputJson,
                          encoding: JSONEncoding.default).responseJSON { response in
                            guard response.result.error == nil else {
                                // got an error in getting the data, need to handle it
                                print("error calling POST on /todos/1")
                                print(response.result.error!)
                                return
                            }
                            // make sure we got some JSON since that's what we expect
                            guard let json = response.result.value as? [String: Any] else {
                                print("didn't get todo object as JSON from API")
                                print("Error: \(String(describing: response.result.error))")
                                return
                            }
//                            print(json)
                            let jsonCopy = JSON(data: response.data!)
                            print(jsonCopy)
                           
                            
                            print("finalizado")
        }
    }
    
    
    
}
