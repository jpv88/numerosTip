//
//  ErrorHandler.swift
//  numerosTip
//
//  Created by Jared Perez Vega on 29/04/2019.
//  Copyright © 2019 Jared Perez Vega. All rights reserved.
//

import UIKit

final class ErrorHandler {
    private enum Localized {
        static let accept = "general_accept".localized()
        static let cancel = "general_cancel".localized()
    }
    
    static func showError(error: Error, dismissButtonTitle: String = Localized.accept, action: (()->())? = nil, dismissAction: (()->())? = nil) {
        let alertView = UIAlertController()
        
        let dismissButton = UIAlertAction(title: dismissButtonTitle, style: .cancel) { _ in
            dismissAction?()
        }
        alertView.title = "Error"
        alertView.message = error.localizedDescription
        alertView.addAction(dismissButton)
        
        guard let currentVC = UIApplication.topViewController() else { return }
        currentVC.present(alertView, animated: true)
    }
    
    static func showAlert(title: String, msg: String, dismissButtonTitle: String = Localized.accept, action: (()->())? = nil, dismissAction: (()->())? = nil) {
        let alertView = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        let dismissButton = UIAlertAction(title: dismissButtonTitle, style: .cancel) { _ in
            dismissAction?()
        }
        
        alertView.addAction(dismissButton)
        
        guard let currentVC = UIApplication.topViewController() else { return }
        currentVC.present(alertView, animated: true)
    }
    
    static func showAlert(title: String, msg: String, actionButtonTitle: String = Localized.accept, action: (()->())? = nil, dismissButtonTitle: String = Localized.cancel, dismissAction: (()->())? = nil) {
        
        let alertView = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        let actionButton = UIAlertAction(title: actionButtonTitle, style: UIAlertActionStyle.default) { _ in
            action?()
        }
        
        let dismissButton = UIAlertAction(title: dismissButtonTitle, style: .cancel) { _ in
            dismissAction?()
        }
        
        alertView.addAction(actionButton)
        alertView.addAction(dismissButton)
        
        guard let currentVC = UIApplication.topViewController() else { return }
        currentVC.present(alertView, animated: true)
    }
}
