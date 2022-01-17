//
//  AddEmployee+Ext.swift
//  EmployeeDBWithMVVm
//
//  Created by Akash S. Kumar on 17/01/22.
//

import Foundation
import UIKit

extension AddEmployeeView : DataPass {
    
    func showEmailSuccess() {
        emailID.translatesAutoresizingMaskIntoConstraints = false
        emailID.leadingView = UIImageView()
        emailID.leadingViewMode = .always
        emailID.setNormalLabelColor(.black, for: .normal)
        emailID.setFloatingLabelColor(.black, for: .editing)
        emailID.setFloatingLabelColor(.black, for: .normal)
        emailID.setLeadingAssistiveLabelColor(.black, for: .editing)
        emailID.setNormalLabelColor(.black, for: .editing)
        emailID.setOutlineColor(.black, for: .editing)
        emailID.setOutlineColor(.black, for: .normal)
        emailID.leadingAssistiveLabel.text = ""
    }
    
    func showEmailError(_ message:String) {
        emailID.becomeFirstResponder()
        emailID.translatesAutoresizingMaskIntoConstraints = false
        emailID.leadingView = createImageView()
        emailID.leadingViewMode = .always
        emailID.setLeadingAssistiveLabelColor(.red, for: .normal)
        emailID.setFloatingLabelColor(.red, for: .editing)
        emailID.setFloatingLabelColor(.red, for: .normal)
        emailID.setNormalLabelColor(.red, for: .normal)
        emailID.setOutlineColor(.red, for: .normal)
        emailID.setLeadingAssistiveLabelColor(.red, for: .editing)
        emailID.setNormalLabelColor(.red, for: .editing)
        emailID.setOutlineColor(.red, for: .editing)
        emailID.leadingAssistiveLabel.text = message
    }
    
    func showPhoneError(_ message:String) {
        phoneNumber.becomeFirstResponder()
        phoneNumber.translatesAutoresizingMaskIntoConstraints = false
        phoneNumber.leadingView = createImageView()
        phoneNumber.leadingViewMode = .always
        phoneNumber.setLeadingAssistiveLabelColor(.red, for: .normal)
        phoneNumber.setFloatingLabelColor(.red, for: .editing)
        phoneNumber.setFloatingLabelColor(.red, for: .normal)
        phoneNumber.setNormalLabelColor(.red, for: .normal)
        phoneNumber.setOutlineColor(.red, for: .normal)
        phoneNumber.setLeadingAssistiveLabelColor(.red, for: .editing)
        phoneNumber.setNormalLabelColor(.red, for: .editing)
        phoneNumber.setOutlineColor(.red, for: .editing)
        phoneNumber.leadingAssistiveLabel.text = message
    }
    
    func addDoneBtn() {
    let toolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0,  width: self.frame.size.width, height: 30))
            let flexSpace = UIBarButtonItem(barButtonSystemItem:    .flexibleSpace, target: nil, action: nil)
            let doneBtn: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissMyKeyboard))
            toolbar.setItems([flexSpace, doneBtn], animated: false)
            toolbar.sizeToFit()
        self.aboutME.textView.inputAccessoryView = toolbar
    }
    
    @objc func dismissMyKeyboard() {
            self.endEditing(true)
        }
    
    func data(object: DataBaseModel, index:Int) {
        aboutME.textView.becomeFirstResponder()
        phoneNumber.text = object.phoneNumber
        emailID.text = object.emailID
        firstNameTextField.text = object.firstName
        lastName.text = object.lastName
        addressTExtField.text = object.address
        aboutME.textView.text = object.aboutYou
        isEdit = true
        self.index = index
    }
     func registerNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let keyboardFrame = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        scrollView.contentInset.bottom = self.convert(keyboardFrame.cgRectValue, from: nil).size.height + 20
    }

    @objc private func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset.bottom = 0
    }
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
                isEdit ? DatabaseHelper.sharedInstance.updateData(object: dict, index: index) :  DatabaseHelper.sharedInstance.save(object: dict)
                self.showSimpleAlert(message: AppConstant.success) {
                    self.clearTextFields()
                }
            } catch(let error) {
                if let messageError = error as? ValidationError {
                    switch messageError.errorType {
                    case .firstName:
                        firstNameTextField.becomeFirstResponder()
                        firstNameTextField.translatesAutoresizingMaskIntoConstraints = false
                        firstNameTextField.leadingView = createImageView()
                        firstNameTextField.leadingViewMode = .always
                        firstNameTextField.setLeadingAssistiveLabelColor(.red, for: .normal)
                        firstNameTextField.setFloatingLabelColor(.red, for: .editing)
                        firstNameTextField.setNormalLabelColor(.red, for: .normal)
                        firstNameTextField.setOutlineColor(.red, for: .normal)
                        firstNameTextField.setLeadingAssistiveLabelColor(.red, for: .editing)
                        firstNameTextField.setNormalLabelColor(.red, for: .editing)
                        firstNameTextField.setOutlineColor(.red, for: .editing)
                        firstNameTextField.leadingAssistiveLabel.text = messageError.message
                    case .lastName:
                        lastName.becomeFirstResponder()
                        lastName.translatesAutoresizingMaskIntoConstraints = false
                        lastName.leadingView = createImageView()
                        lastName.leadingViewMode = .always
                        lastName.setLeadingAssistiveLabelColor(.red, for: .normal)
                        lastName.setFloatingLabelColor(.red, for: .editing)
                        lastName.setNormalLabelColor(.red, for: .normal)
                        lastName.setOutlineColor(.red, for: .normal)
                        lastName.setLeadingAssistiveLabelColor(.red, for: .editing)
                        lastName.setNormalLabelColor(.red, for: .editing)
                        lastName.setOutlineColor(.red, for: .editing)
                        lastName.leadingAssistiveLabel.text = messageError.message
                    case .email:
                        showEmailError(messageError.message)
                    case .phone:
                        showPhoneError(messageError.message)
                    }
                }
            }
        }
    }

    extension AddEmployeeView: UITextFieldDelegate {
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
                self.endEditing(true)
                return false
            }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            switch textField {
            case emailID:
                do {
                    _ = try emailID.validatedText(validationType: ValidatorType.email,
                                                            visibility: true)
                } catch (let error) {
                    if let messageError = error as? ValidationError {
                    showEmailError(messageError.message)
                    }
                }
            case phoneNumber:
                do {
                    _ = try phoneNumber.validatedText(validationType: ValidatorType.phone,
                                                            visibility: true)
                } catch (let error) {
                    if let messageError = error as? ValidationError {
                        showPhoneError(messageError.message)
                    }
                }
            default:
                print("Not handled")
            }
        }
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            switch textField {
            case firstNameTextField:
                if firstNameTextField.text != "" {
                    firstNameTextField.translatesAutoresizingMaskIntoConstraints = false
                    firstNameTextField.leadingView = UIImageView()
                    firstNameTextField.leadingViewMode = .always
                    firstNameTextField.setFloatingLabelColor(.black, for: .editing)
                    firstNameTextField.setLeadingAssistiveLabelColor(.black, for: .editing)
                    firstNameTextField.setNormalLabelColor(.black, for: .editing)
                    firstNameTextField.setOutlineColor(.black, for: .editing)
                    firstNameTextField.setOutlineColor(.black, for: .normal)
                    firstNameTextField.leadingAssistiveLabel.text = ""
                }
                firstNameTextField.setNormalLabelColor(.black, for: .normal)
            case lastName:
                if lastName.text != "" {
                    lastName.translatesAutoresizingMaskIntoConstraints = false
                    lastName.leadingView = UIImageView()
                    lastName.leadingViewMode = .always
                    lastName.setFloatingLabelColor(.black, for: .editing)
                    lastName.setLeadingAssistiveLabelColor(.black, for: .editing)
                    lastName.setNormalLabelColor(.black, for: .editing)
                    lastName.setOutlineColor(.black, for: .editing)
                    lastName.setOutlineColor(.black, for: .normal)
                    lastName.leadingAssistiveLabel.text = ""
                }
                lastName.setNormalLabelColor(.black, for: .normal)
            case emailID:
                if emailID.text != "" {
                    showEmailSuccess()
                }
                emailID.setNormalLabelColor(.black, for: .normal)
            case phoneNumber:
                if phoneNumber.text != "" {
                    phoneNumber.translatesAutoresizingMaskIntoConstraints = false
                    phoneNumber.leadingView = UIImageView()
                    phoneNumber.leadingViewMode = .always
                    phoneNumber.setFloatingLabelColor(.black, for: .normal)
                    phoneNumber.setFloatingLabelColor(.black, for: .editing)
                    phoneNumber.setLeadingAssistiveLabelColor(.black, for: .editing)
                    phoneNumber.setNormalLabelColor(.black, for: .editing)
                    phoneNumber.setOutlineColor(.black, for: .editing)
                    phoneNumber.setOutlineColor(.black, for: .normal)
                    phoneNumber.leadingAssistiveLabel.text = ""
                }
                phoneNumber.setNormalLabelColor(.black, for: .normal)
            default:
                print("case is not handled")
            }
            return true
        }
    }
