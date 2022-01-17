//
//  ViewControllerViewModel.swift
//  EmployeeDBWithMVVm
//
//  Created by Akash S. Kumar on 05/01/22.
//

import Foundation
import UIKit

class ViewControllerViewModel: NSObject {
   private var dataModel = [Employee]() {
       didSet {
           self.reloadTableView?()
       }
   }
  var reloadTableView: (()->())?
    
    var numberOfCells: Int {
        return dataModel.count
    }
    func setCellViewModel(_ employee:[Employee]) {
        self.dataModel = employee
    }
    
    func getCellViewModel( at indexPath: IndexPath ) -> Employee {
        return dataModel[indexPath.row]
    }
}

struct DataBaseModel {
    var firstName: String?
    var lastName: String?
    var emailID: String?
    var phoneNumber: String?
    var address: String?
    var aboutYou: String?
}
