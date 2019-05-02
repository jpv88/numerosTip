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
    
    static private let url = "http://tulengua.es/ServicioNumeros/Numeros.asmx/"
    static private let method = "Convertir"
    static private let token = "9P384RUPIQW7RY5234"
    static private let userID = "iOSJared"
    static private let absolutPath = url + method
    static private var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    static private var spinnerContainer: UIView = UIView()
    
    class func requestWebService(reference: UIViewController, number: String, completionHandler: @escaping (NumerosTipDataModel) -> Void, serviceError: @escaping (Error) -> Void) {
        let interface = Locale.preferredLanguages[0].prefix(2).lowercased()
        let vc = UIApplication.topViewController()
        vc?.showLoader()
        let userDefault = UserDefaults.standard
        guard let language = userDefault.object(forKey: Constans.languageKEY) as? String else {return}        
        let inputJson: [String : Any] = ["numeroText":number,
                                         "lang":language.lowercased(),
                                         "langInterface":interface,
                                         "token":token,
                                         "userId": userID
        ]
        Alamofire.request(absolutPath, method: .post, parameters: inputJson,
                          encoding: JSONEncoding.default).responseJSON { response in
                            
                            vc?.hideLoader()
                            
                            switch response.result {
                            case .success( _):
                                guard let data = response.data else { return }
                                guard let json = try? JSON(data: data) else {return}
                                let response = NumerosTipDataModel(data: json)
                                completionHandler(response)
                                break
                            case .failure(let error):
                                serviceError(error)
                                return
                            }
                            
        }
    }    
    
}
