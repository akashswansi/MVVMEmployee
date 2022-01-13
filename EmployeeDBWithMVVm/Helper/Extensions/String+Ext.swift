//
//  String+Ext.swift
//  EmployeeDBWithMVVm
//
//  Created by Akash S. Kumar on 13/01/22.
//

import Foundation
import UIKit

extension String {
    func trim() -> String {
        return self.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
    }
}
