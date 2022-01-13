//
//  ViewControllerViewModel.swift
//  EmployeeDBWithMVVm
//
//  Created by Akash S. Kumar on 05/01/22.
//

import Foundation
import UIKit

class ViewControllerViewModel: NSObject {
    private var dataModel = [Employee]()
    func refreshWith(data: [Employee], _ completionBlock : @escaping ()->()) {
        self.dataModel = data
        completionBlock()
    }
}

extension ViewControllerViewModel: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if let tmp = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as? CustomTableViewCell {
            tmp.configureCell(dataModel[indexPath.row])
            cell = tmp
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        switch editingStyle {
        case .delete:
            let indexPathDict:[String: IndexPath] = ["indexPath": indexPath]
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "DeleteRow"), object: nil, userInfo: indexPathDict)
        default:
            print("case is not handled")
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dict = [indexPath.row:DataBaseModel(firstName: dataModel[indexPath.row].firstName ?? "", lastName: dataModel[indexPath.row].lastName ?? "", emailID: dataModel[indexPath.row].emailID ?? "", phoneNumber: dataModel[indexPath.row].phoneNumber ?? "", address: dataModel[indexPath.row].address, aboutYou: dataModel[indexPath.row].aboutYou)]
        let model:[String: [Int:DataBaseModel]] = ["databaseModel": dict]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UpdateRow"), object: nil, userInfo: model)
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
