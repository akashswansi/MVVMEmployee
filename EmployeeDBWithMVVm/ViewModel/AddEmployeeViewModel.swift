//
//  AddEmployeeViewModel.swift
//  EmployeeDBWithMVVm
//
//  Created by Akash S. Kumar on 07/02/22.
//

import Foundation
import UIKit

class AddEmployeeViewModel: NSObject {
    
    var isEdit = false
    private var employee:Employee! {
        didSet {
            self.saveData?()
        }
    }
  var saveData: (()->())?
    
    func setCellViewModel(_ employee:Employee) {
        self.employee = employee
    }
    
    func getCellViewModel() -> Employee {
        return employee
    }
}
