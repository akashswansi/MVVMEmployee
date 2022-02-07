//
//  AlertMessage.swift
//  EmployeeDBWithMVVm
//
//  Created by Akash S. Kumar on 13/01/22.
//

import Foundation
/// Alert Messages to be used in whole app
struct AlertMessage {
    // General Messages
    
    static let requireEmail = NSLocalizedString("Please enter email", comment: "")
    static let invalidEmail = NSLocalizedString("Please enter valid email", comment: "")
    static let requireMobile = NSLocalizedString("Please enter phone number", comment: "")
    static let invalidMobile = NSLocalizedString("Please enter valid phone number", comment: "")
    static let requirefirstName = NSLocalizedString("Please enter first name", comment: "")
    static let requirelastName = NSLocalizedString("Please enter last name", comment: "")
    static let minValueFirstName = NSLocalizedString("First Name must contain more than 1 character", comment: "")
    static let maxValueFirstName = NSLocalizedString("First Name shoudn't contain more than 80 characters", comment: "")
    static let invalidFirstName = NSLocalizedString("Please enter a valid first name.", comment: "")
    static let minValueLastName = NSLocalizedString("Last Name must contain more than 1 character", comment: "")
    static let maxValueLastName = NSLocalizedString("Last Name shoudn't contain more than 80 characters", comment: "")
    static let invalidLastName = NSLocalizedString("Please enter a valid last name.", comment: "")
}
