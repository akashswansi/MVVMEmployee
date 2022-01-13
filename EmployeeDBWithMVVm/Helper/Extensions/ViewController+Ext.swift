//
//  ListViewController+Ext.swift
//  EmployeeDBWithMVVm
//
//  Created by Akash S. Kumar on 13/01/22.
//

import Foundation
import UIKit

extension ViewController {
    
    func validateFields() {
        do {
            _ = try firstNameTextField.validatedText(validationType: ValidatorType.firstName,
                                                    visibility: true)
            _ = try lastName.validatedText(validationType: ValidatorType.lastName,
                                                    visibility: true)
            _ = try emailID.validatedText(validationType: ValidatorType.email,
                                                    visibility: true)
            _ = try phoneNumber.validatedText(validationType: ValidatorType.phone,
                                                    visibility: true)
            dict = DataBaseModel(firstName: firstNameTextField.text ?? "", lastName: lastName.text ?? "", emailID: emailID.text ?? "", phoneNumber: phoneNumber.text ?? "", address: addressTExtField.text ?? "", aboutYou: aboutME.textView.text ?? "")
            isEdit ? DatabaseHelper.sharedInstance.editData(object: dict, index: index) :  DatabaseHelper.sharedInstance.save(object: dict)
            self.showSimpleAlert(message: AppConstant.success) {
                self.clearTextFields()
            }
        } catch(let error) {
            if let messageError = error as? ValidationError {
                switch messageError.errorType {
                case .firstName:
                    firstNameTextField.becomeFirstResponder()
                    firstNameTextField.setOutlineColor(.red, for: .normal)
                    firstNameTextField.leadingAssistiveLabel.text = messageError.message
                case .lastName:
                    lastName.becomeFirstResponder()
                    lastName.setOutlineColor(.red, for: .normal)
                    lastName.leadingAssistiveLabel.text = messageError.message
                case .email:
                    emailID.becomeFirstResponder()
                    emailID.setOutlineColor(.red, for: .normal)
                    emailID.leadingAssistiveLabel.text = messageError.message
                case .phone:
                    phoneNumber.becomeFirstResponder()
                    phoneNumber.setOutlineColor(.red, for: .normal)
                    phoneNumber.leadingAssistiveLabel.text = messageError.message
                }
            }
        }
    }
}

extension ViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField {
        case firstNameTextField:
            if firstNameTextField.text != "" {
                firstNameTextField.setOutlineColor(.black, for: .normal)
                firstNameTextField.leadingAssistiveLabel.text = ""
            }
        case lastName:
            if lastName.text != "" {
                lastName.setOutlineColor(.black, for: .normal)
                lastName.leadingAssistiveLabel.text = ""
            }
        case emailID:
            if emailID.text != "" {
                emailID.setOutlineColor(.black, for: .normal)
                emailID.leadingAssistiveLabel.text = ""
            }
        case phoneNumber:
            if phoneNumber.text != "" {
                phoneNumber.setOutlineColor(.black, for: .normal)
                phoneNumber.leadingAssistiveLabel.text = ""
            }
        default:
            print("case is not handled")
        }
        return true
    }
}
