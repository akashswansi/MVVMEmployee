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
extension UIView {
    func performFloating(with label:RegisterLabel, requiredLabel: UILabel?, field:DesignableTextField, topAnchor:NSLayoutConstraint, fieldTopAnchor:NSLayoutConstraint, endEditing:Bool, color:UIColor, fieldTop:CGFloat) {
        if endEditing {
            field.borderWidth = 1
            field.borderColor = .lightGray
            if field.text?.count == 0 {
                let required = label.text != nil //label.text == "Apt/Suite/Floor" ? false : true
                field.placeHolder(label.text!, error: false, required: required, color: color)
                floatDown(label, requiredLabel:requiredLabel, topAnchor: topAnchor, fieldTopAnchor: fieldTopAnchor, fieldTop: fieldTop)
            }
        } else {
            field.leadingImage = nil
            field.textColor = .lightGray
            label.textColor = .lightGray
            field.attributedPlaceholder = nil
            field.borderWidth = 2
            field.borderColor = .black
            floatUP(label, requiredLabel:requiredLabel, topAnchor: topAnchor, fieldTopAnchor: fieldTopAnchor)
        }
    }
    
    private func floatUP(_ label:RegisterLabel, requiredLabel:UILabel?, topAnchor:NSLayoutConstraint, fieldTopAnchor:NSLayoutConstraint) {
        if label.float {
            return
        }
        
        label.float = true
        label.isHidden = false
        requiredLabel?.isHidden = false
        topAnchor.constant = -8
        fieldTopAnchor.constant = 40
        label.setNeedsLayout()
        UIView.transition(with: label, duration: 0.4, options: .curveLinear, animations: {
            self.layoutIfNeeded()
            label.alpha = 1
            requiredLabel?.alpha = 1
        }, completion: nil)
    }
    
    private func floatDown(_ label:RegisterLabel, requiredLabel:UILabel?, topAnchor:NSLayoutConstraint, fieldTopAnchor:NSLayoutConstraint, fieldTop:CGFloat) {
        if !label.float {
            return
        }
        
        label.float = false
        topAnchor.constant = 0
        fieldTopAnchor.constant = fieldTop
        UIView.transition(with: label, duration: 0.4, options: .curveLinear, animations: {
            self.layoutIfNeeded()
            label.alpha = 0
            requiredLabel?.alpha = 0
        }, completion: { _ in
            label.isHidden = true
            requiredLabel?.isHidden = true
        })
    }
}
