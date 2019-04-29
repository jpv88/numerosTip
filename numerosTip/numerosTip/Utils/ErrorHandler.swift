//
//  ErrorHandler.swift
//  numerosTip
//
//  Created by Jared Perez Vega on 29/04/2019.
//  Copyright © 2019 Jared Perez Vega. All rights reserved.
//

import UIKit

final class ErrorHandler {
    static func showError(error: Error, firstButtonTitle: String = "Ok", dismissButtonTitle: String = "Aceptar", action: (()->())? = nil, dismissAction: (()->())? = nil) {
        let alertView = UIAlertController()
        let firstButton = UIAlertAction(title: firstButtonTitle, style: .default) { _ in
            action?()
        }
        
        let dismissButton = UIAlertAction(title: dismissButtonTitle, style: .cancel) { _ in
            dismissAction?()
        }
        alertView.title = "Error"
        alertView.message = error.localizedDescription
        alertView.addAction(firstButton)
        alertView.addAction(dismissButton)
        
        guard let currentVC = UIApplication.topViewController() else { return }
        currentVC.present(alertView, animated: true)
    }
    
    static func showAlert(title: String, msg: String, dismissButtonTitle: String = "Aceptar", action: (()->())? = nil, dismissAction: (()->())? = nil) {
        let alertView = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        let dismissButton = UIAlertAction(title: dismissButtonTitle, style: .cancel) { _ in
            dismissAction?()
        }
        
        alertView.addAction(dismissButton)
        
        guard let currentVC = UIApplication.topViewController() else { return }
        currentVC.present(alertView, animated: true)
    }
}
