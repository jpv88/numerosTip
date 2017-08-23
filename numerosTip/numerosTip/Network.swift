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

protocol activityIndicatorDelegate {
    func showLoading()
    func hideLoading()
}

class Network: NSObject {

    static var delegate: activityIndicatorDelegate?
    static var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    static var spinnerContainer: UIView = UIView()
    
    class func requestWebService(reference: UIViewController? = nil) {
        
//        if (reference != nil){
//          self.delegate?.showLoading()
//        }
        
        showIndicatorInCaller(parent: reference!)
        
        let url = "http://tip.dis.ulpgc.es/ServicioNumeros/Numeros.asmx/ConvierteNumero"
        let inputJson: [String : Any] = ["numeroText":13,
                                         "lang":"es"]
        
        Alamofire.request(url, method: .post, parameters: inputJson,
                          encoding: JSONEncoding.default).responseJSON { response in
                            guard response.result.error == nil else {
                                // got an error in getting the data, need to handle it
                                print("error calling POST on /todos/1")
                                print(response.result.error!)
                                if (reference != nil){
                                    hideIndicatorInCaller()
                                }
                                return
                            }
                            // make sure we got some JSON since that's what we expect
                            guard let json = response.result.value as? [String: Any] else {
                                print("didn't get todo object as JSON from API")
                                print("Error: \(String(describing: response.result.error))")
                                if (reference != nil){
                                    hideIndicatorInCaller()
                                }
                                return
                            }
//                            print(json)
                            let jsonCopy = JSON(data: response.data!)
                            print(jsonCopy)
                           
                            
                            print("finalizado")
//                            if (reference != nil){
//                                self.delegate?.hideLoading()
//                            }
                            hideIndicatorInCaller()
        }
    }
    
    static func showIndicatorInCaller(parent: UIViewController) {
        
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
        
        UIApplication.shared.beginIgnoringInteractionEvents()
    }

    static func hideIndicatorInCaller() {
        self.activityIndicator.stopAnimating()
        self.spinnerContainer.removeFromSuperview()
        UIApplication.shared.endIgnoringInteractionEvents()
    }
    
}
