//
//  Validator.swift
//  EmployeeDBWithMVVm
//
//  Created by Akash S. Kumar on 13/01/22.
//

import Foundation
import UIKit

/// Validator Error class
class ValidationError: Error {
    var message: String
    var errorType:errorType
    init(_ message: String,_ error:errorType) {
        self.message = message
        self.errorType = error
    }
}

enum errorType {
    case firstName
    case lastName
    case email
    case phone
}
/// Protocol for validator
protocol ValidatorConvertible {
    func validated(_ value: String) throws -> String
}

/// Enum for Validator type
///
enum ValidatorType {
    /// - firstName: firstName
    case firstName
    /// - lastName: lastName
    case lastName
    /// - email: Email
    case email
    /// - phone: Phone
    case phone
}

///Enum for Validator methods
enum VaildatorFactory {
    /// Method to define validator type to return appropriate exception
    ///
    /// - Parameter type: Validator type
    /// - Returns: Returns exception value
    static func validatorFor(type: ValidatorType) -> ValidatorConvertible {
        switch type {
        case .firstName: return FirstNameValidator()
        case .lastName: return LastNameValidator()
        case .email: return EmailValidator()
        case .phone: return PhoneValidator()
        }
    }
}


/// Class for Phone Validator
class PhoneValidator: ValidatorConvertible {
    /// Validation for phone number
    ///
    /// - Parameter value: Value of textfield
    /// - Returns: returns message
    /// - Throws: throws exception if any error
    func validated(_ value: String) throws -> String {
        guard value.count > 0 else {throw ValidationError(AlertMessage.requireMobile, errorType.phone)}
        //guard value.count < 15 else {throw ValidationError(AlertMessage.invalidMobile)}
        guard (value.count > 0 && value.count == 14)  else {throw ValidationError(AlertMessage.invalidMobile, errorType.phone)}
        return value
    }
}



/// Email Validator
struct EmailValidator: ValidatorConvertible {
    /// Validate Email
    ///
    /// - Parameter value: String Value
    /// - Returns: Returns message
    /// - Throws: Throws exception
    func validated(_ value: String) throws -> String {
        guard value.count > 0 else {throw ValidationError(AlertMessage.requireEmail, errorType.email)}
        //old   ^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$
        
        
        do {
            if try NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw ValidationError(AlertMessage.invalidEmail, errorType.email)
            }
        } catch {
            throw ValidationError(AlertMessage.invalidEmail, errorType.email)
        }
        return value
    }
}

/// First name Validator
struct FirstNameValidator: ValidatorConvertible {
    /// Validate firstname
    ///
    /// - Parameter value: String Value
    /// - Returns: Returns message
    /// - Throws: Throws exception
    func validated(_ value: String) throws -> String {
        guard value.count > 0 else {throw ValidationError(AlertMessage.requirefirstName, errorType.firstName)}
        
        guard value.count >= 1 else {
            throw ValidationError(AlertMessage.minValueFirstName, errorType.firstName)
        }
        guard value.count < 80 else {
            throw ValidationError(AlertMessage.maxValueFirstName, errorType.firstName)
        }
        do {
            let regex = try NSRegularExpression(pattern: ".*[^A-Za-z ].*", options: [])
            if regex.firstMatch(in: value, options: [], range: NSMakeRange(0, value.count)) != nil {
                throw ValidationError(AlertMessage.invalidFirstName, errorType.firstName)
            }
        } catch {
            throw ValidationError(AlertMessage.invalidFirstName, errorType.firstName)
        }
        return value
    }
}

/// Last name Validator
struct LastNameValidator: ValidatorConvertible {
    /// Validate Last name
    ///
    /// - Parameter value: String Value
    /// - Returns: Returns message
    /// - Throws: Throws exception
    func validated(_ value: String) throws -> String {
        guard value.count > 0 else {throw ValidationError(AlertMessage.requirelastName, errorType.lastName)}
        
        guard value.count >= 1 else {
            throw ValidationError(AlertMessage.minValueLastName, errorType.lastName)
        }
        guard value.count < 80 else {
            throw ValidationError(AlertMessage.maxValueLastName, errorType.lastName)
        }
        
        do {
            let regex = try NSRegularExpression(pattern: ".*[^A-Za-z ].*", options: [])
            if regex.firstMatch(in: value, options: [], range: NSMakeRange(0, value.count)) != nil {
                throw ValidationError(AlertMessage.invalidLastName, errorType.lastName)
            }
        } catch {
            throw ValidationError(AlertMessage.invalidLastName, errorType.lastName)
        }
        return value
    }
}

