//
//  UIViewController+Alert.swift
//  TestAlaskar
//
//  Created by Mariya on 18.11.16.
//  Copyright © 2016 Kilograpp. All rights reserved.
//

import Foundation
import UIKit

protocol Alerts {
    func showAlert(title: String)
    func showAlert(title: String, message: String)
}

extension UIViewController: Alerts {
    
    func showAlert(title: String) {
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ok".localized, style: UIAlertActionStyle.default) { (UIAlertAction) in
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ok".localized, style: UIAlertActionStyle.default) { (UIAlertAction) in
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
