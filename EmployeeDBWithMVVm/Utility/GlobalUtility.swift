//
//  GlobalUtility.swift
//  EmployeeDBWithMVVm
//
//  Created by Akash S. Kumar on 12/01/22.
//

import Foundation
import UIKit

class GlobalUtility: NSObject {
    
   
    
    /// Shared instance of the globalutility class
    static let shared: GlobalUtility = {
        let instance = GlobalUtility()
        // setup code
        return instance
    }()
    
    /// - ADD custom Font and colour
    class func customFontString(_ string: String, font:UIFont?, color:UIColor?) -> NSAttributedString {
        if font != nil && color != nil {
            let stringAttributes = [NSAttributedString.Key.font : font!, NSAttributedString.Key.foregroundColor: color!]
            let customString = NSAttributedString(string: string, attributes:stringAttributes)
            return customString
        }
        return NSAttributedString()
    }
    
}
