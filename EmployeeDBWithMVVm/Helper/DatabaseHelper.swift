//
//  DatabaseHelper.swift
//  EmployeeDBWithMVVm
//
//  Created by Akash S. Kumar on 05/01/22.
//

import Foundation
import CoreData
import UIKit

class DatabaseHelper {
    static var sharedInstance = DatabaseHelper()
    private init() {
    }
    var employeeProvider:EmployeeProvider!
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    func save(object:DataBaseModel) {
        if let context = self.context {
        let employee = NSEntityDescription.insertNewObject(forEntityName: "Employee", into: context) as! Employee
            employee.firstName = object.firstName
            employee.lastName = object.lastName
            employee.emailID = object.emailID
            employee.phoneNumber = object.phoneNumber
            employee.address = object.address
            employee.aboutYou = object.aboutYou
            do {
                try context.save()
            } catch {
                print("Data does not save")
            }
        }
    }
    
    
    func getEmployeeData() -> [Employee] {
        var employee = [Employee]()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Employee")
        do {
            employee = try context?.fetch(fetchRequest) as! [Employee]
        } catch {
            print("Can't able to find the data")
        }
        return employee
    }
    
    func deleteData(_ index:Int) -> [Employee] {
        var employee = getEmployeeData()
        context?.delete(employee[index])
        employee.remove(at: index)
        do {
            try context?.save()
        } catch {
            print("cannot able to delete data")
        }
        return employee
    }
    
    func editData(object:DataBaseModel, index:Int) {
        let employee = getEmployeeData()
        employee[index].firstName = object.firstName
        employee[index].lastName = object.lastName
        employee[index].phoneNumber = object.phoneNumber
        employee[index].emailID = object.emailID
        employee[index].address = object.address
        employee[index].aboutYou = object.aboutYou
        do {
            try context?.save()
        } catch {
            print("cannot able to save data")
        }
    }
    
    func fetchSearchedData(searchStr:String)-> [Employee] {
        var employee = [Employee]()
        let predicate = NSPredicate(format: "firstName contains %@", searchStr)
        let lastNamePredicate = NSPredicate(format: "lastName contains %@", searchStr)
        let emailPredicate = NSPredicate(format: "emailID contains %@", searchStr)
        let orPredicate = NSCompoundPredicate(type: NSCompoundPredicate.LogicalType.or, subpredicates: [predicate, lastNamePredicate, emailPredicate])
        let request: NSFetchRequest = Employee.fetchRequest()
        request.predicate = orPredicate
        do {
            employee = try (context!.fetch(request))
        } catch {
            print("Error while fetching data")
        }
        return employee
    }
}
