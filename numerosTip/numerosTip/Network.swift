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

    static private let url = "http://tip.dis.ulpgc.es/ServicioNumeros/Numeros.asmx/"
    static private let method = "Convertir"
    static private let token = "9P384RUPIQW7RY5234"
    static private let absolutPath = url + method
    static private var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    static private var spinnerContainer: UIView = UIView()
    
    class func requestWebService(reference: UIViewController, completionHandler: @escaping (NumerosTipDataModel) -> Void) {
        
        showIndicatorInCaller(parent: reference)
        
        let inputJson: [String : Any] = ["numeroText":"13",
                                         "lang":"es",
                                         "langInterface":"es",
                                         "token":token
                                         ]
        Alamofire.request(absolutPath, method: .post, parameters: inputJson,
                          encoding: JSONEncoding.default).responseJSON { response in
                            
//                            if let status = response.response?.statusCode {
//                                switch(status){
//                                case 201:
//                                    print("example success")
//                                default:
//                                    print("error with response status: \(status)")
//                                }
//                            }
//
//                            switch response.result {
//                            case .success(let value):
//                                print(value)
//                                break
//                            case .failure(let error):
//                                print(error)
//                                break
//                            }
//
//                            if let result = response.result.value {
//                                let dictionary = result as! NSDictionary
//                                let jsonData: NSData = try! JSONSerialization.data(withJSONObject: dictionary, options: JSONSerialization.WritingOptions.prettyPrinted) as NSData
//                                let prettyStr = NSString(data: jsonData as Data, encoding: String.Encoding.utf8.rawValue)! as String
//                                print(prettyStr)
//                                do {
//                                    let numbersTipModel = try NumbersTipModel.init(prettyStr)
////                                    print(numbersTipModel as Any)
//                                } catch _ as NSError {
//
//                                }
//
//
//                            }
//
                            hideIndicatorInCaller()
                            
                            
                            
                            
                            guard response.result.error == nil else {
                                // got an error in getting the data, need to handle it
                                print("error calling POST on /todos/1")
                                print(response.result.error!)
                                hideIndicatorInCaller()
                                return
                            }
                            // make sure we got some JSON since that's what we expect
                            guard let json = response.result.value as? [String: Any] else {
                                print("didn't get todo object as JSON from API")
                                print("Error: \(String(describing: response.result.error))")
                                hideIndicatorInCaller()
                                return
                            }

                            let jsonCopy = JSON(data: response.data!)
                            
                            print("finalizado")
                            hideIndicatorInCaller()
                            
                            let response = NumerosTipDataModel(data: jsonCopy)
                            
//                             Do actions
                            completionHandler(response)
        }
    }
    
    // MARK: - Loading Spinner
    
    static func showIndicatorInCaller(parent: UIViewController) {
        
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        self.spinnerContainer.frame = parent.view.frame
        self.spinnerContainer.center = parent.view.center
        self.spinnerContainer.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        
        let loadingView: UIView = UIView()
        loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        loadingView.center = parent.view.center
        loadingView.backgroundColor = UIColor.darkGray.withAlphaComponent(0.7)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        self.activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        self.activityIndicator.activityIndicatorViewStyle =
            UIActivityIndicatorViewStyle.whiteLarge
        self.activityIndicator.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2)
        self.activityIndicator.hidesWhenStopped = true
        
        loadingView.addSubview(self.activityIndicator)
        
        self.spinnerContainer.addSubview(loadingView)
        
        parent.view.addSubview(self.spinnerContainer)
        
        self.activityIndicator.startAnimating()
        
    }

    static func hideIndicatorInCaller() {
        self.activityIndicator.stopAnimating()
        self.spinnerContainer.removeFromSuperview()
        UIApplication.shared.endIgnoringInteractionEvents()
    }
    
}
