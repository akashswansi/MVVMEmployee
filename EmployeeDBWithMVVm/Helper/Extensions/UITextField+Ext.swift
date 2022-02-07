//
//  UITextField+Ext.swift
//  EmployeeDBWithMVVm
//
//  Created by Akash S. Kumar on 13/01/22.
//

import Foundation
import UIKit

extension UITextField {
    /// Validate the textfield value input
    ///
    /// - Parameters:
    ///   - validationType:Type of validator(Type of textfield)
    ///   - visibility: Whether textifled is visible or not
    ///   - optional: Whether textfield is optional or not
    ///   - becomeFirstResponder: Whether textfield should become first responder
    /// - Returns: Returns Message
    /// - Throws: Throes exception if any error
    func validatedText(validationType: ValidatorType, visibility: Bool = true, optional: Bool = false, becomeFirstResponder: Bool = true,_ type:ValidatorType?, _ isFromSave:Bool) throws -> String {
        if (visibility == true && optional == false) || (visibility == true && optional == true  && self.text != "") {
            let validator = VaildatorFactory.validatorFor(type: validationType)
           
            return try validator.validated(self.text!.trim(), type, isFromSave)
        } else {
            return ""
        }
    }
    
   
}
