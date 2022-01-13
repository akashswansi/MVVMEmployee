//
//  UiViewController+Ext.swift
//  EmployeeDBWithMVVm
//
//  Created by Akash S. Kumar on 12/01/22.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showSimpleAlert(message:String, okAction: (() -> Void)? = nil)   {
        let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
            
            if let _ = okAction
            {
                okAction!()
            }
            
        }
        alertController.addAction(action)
        
        self.present(alertController, animated: true, completion: nil)
    }
}
