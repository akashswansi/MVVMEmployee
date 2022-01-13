//
//  Employee+CoreDataProperties.swift
//  EmployeeDBWithMVVm
//
//  Created by Akash S. Kumar on 05/01/22.
//
//

import Foundation
import CoreData


extension Employee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Employee> {
        return NSFetchRequest<Employee>(entityName: "Employee")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var emailID: String?
    @NSManaged public var phoneNumber: String?
    @NSManaged public var address: String?
    @NSManaged public var aboutYou: String?

}

extension Employee : Identifiable {

}
