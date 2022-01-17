//
//  UIView+Ext.swift
//  EmployeeDBWithMVVm
//
//  Created by Akash S. Kumar on 17/01/22.
//

import Foundation
import UIKit

extension UIView {
    func showSimpleAlert(message:String, okAction: (() -> Void)? = nil)   {
        if let parentViewController: UIViewController = UIApplication.shared.windows[1].rootViewController {
        let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
            
            if let _ = okAction
            {
                okAction!()
            }
            
        }
        alertController.addAction(action)
        
        parentViewController.present(alertController, animated: true, completion: nil)
        }
    }
}
