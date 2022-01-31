//
//  AddEmployeeDetails+EXT.swift
//  EmployeeDBWithMVVm
//
//  Created by Akash S. Kumar on 31/01/22.
//

import Foundation
import UIKit

extension AddEmployee : DataPass {
    
    func showEmailError(_ message:String) {
        emailIDErrorLabel.isHidden = false
        emailIDTextField.borderColor = .red
        emailIDTextField.leadingImage = UIImage(named: "error")
        emailIDTextField.padding = 10
        emailIDLabel.textColor = .red
        
    }

    func showPhoneError(_ message:String) {
        phoneNumberErrorLabel.isHidden = false
        phoneNumberTextField.borderColor = .red
        phoneNumberTextField.leadingImage = UIImage(named: "error")
        phoneNumberTextField.padding = 10
        phoneNumberLabel.textColor = .red
    }
  
    @objc func dismissMyKeyboard() {
            self.endEditing(true)
        }

    func data(object: DataBaseModel, index:Int) {
        aboutMeTextField.becomeFirstResponder()
        phoneNumberTextField.text = object.phoneNumber
        emailIDTextField.text = object.emailID
        firstNameTextField.text = object.firstName
        lastNameTextField.text = object.lastName
        addressTextField.text = object.address
        aboutMeTextField.text = object.aboutYou
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
                _ = try lastNameTextField.validatedText(validationType: ValidatorType.lastName,
                                                        visibility: true)
                _ = try emailIDTextField.validatedText(validationType: ValidatorType.email,
                                                        visibility: true)
                _ = try phoneNumberTextField.validatedText(validationType: ValidatorType.phone,
                                                        visibility: true)
                dict = DataBaseModel(firstName: firstNameTextField.text ?? "", lastName: lastNameTextField.text ?? "", emailID: emailIDTextField.text ?? "", phoneNumber: phoneNumberTextField.text ?? "", address: addressTextField.text ?? "", aboutYou: aboutMeTextField.text ?? "")
                isEdit ? DatabaseHelper.sharedInstance.updateData(object: dict, index: index) :  DatabaseHelper.sharedInstance.save(object: dict)
                self.showSimpleAlert(message: AppConstant.success) {
                    self.clearTextFields()
                }
            } catch(let error) {
                if let messageError = error as? ValidationError {
                    switch messageError.errorType {
                    case .firstName:
                        firstNameError.isHidden = false
                        firstNameTextField.borderColor = .red
                        firstNameTextField.leadingImage = UIImage(named: "error")
                        firstNameTextField.padding = 10
                        firstNameTextField.textColor = .red
                    case .lastName:
                        lastNameErrorLabel.isHidden = false
                        lastNameTextField.borderColor = .red
                        lastNameTextField.leadingImage = UIImage(named: "error")
                        lastNameTextField.padding = 10
                        lastNameTextField.textColor = .red
                    case .email:
                        showEmailError(messageError.message)
                    case .phone:
                        showPhoneError(messageError.message)
                    }
                }
            }
        }
    }

    extension AddEmployee: UITextFieldDelegate {
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
                self.endEditing(true)
                return false
            }
        
        func textFieldDidBeginEditing(_ textField: UITextField) {
            switch textField {
            case firstNameTextField:
                firstNameError.isHidden = true
                performFloating(with: firstNameLabel, requiredLabel: nil, field: firstNameTextField, topAnchor: firstNameLabelTop, fieldTopAnchor: firstNameTextFieldTop, endEditing: false, color: .lightGray, fieldTop: 21.0)
            case lastNameTextField:
                lastNameErrorLabel.isHidden = true
                performFloating(with: lastNameLabel, requiredLabel: nil, field: lastNameTextField, topAnchor: lastNameLabelTop, fieldTopAnchor: lastNameTextFieldTop, endEditing: false, color: .lightGray, fieldTop: 21.0)
            case emailIDTextField:
                emailIDErrorLabel.isHidden = true
                performFloating(with: emailIDLabel, requiredLabel: nil, field: emailIDTextField, topAnchor: emailIDLabelTop, fieldTopAnchor: emailIDTextFieldTop, endEditing: false, color: .lightGray, fieldTop: 21.0)
            case phoneNumberTextField:
                phoneNumberErrorLabel.isHidden = true
                performFloating(with: phoneNumberLabel, requiredLabel: nil, field: phoneNumberTextField, topAnchor: phoneNumberLabelTop, fieldTopAnchor: phoneNumberTextFieldTop, endEditing: false, color: .lightGray, fieldTop: 21.0)
            case addressTextField:
                performFloating(with: addressLabel, requiredLabel: nil, field: addressTextField, topAnchor: addressLabelTop, fieldTopAnchor: addressTextFieldTop, endEditing: false, color: .lightGray, fieldTop: 21.0)
            case aboutMeTextField:
                performFloating(with: aboutMeLabel, requiredLabel: nil, field: aboutMeTextField, topAnchor: aboutMeLabelTop, fieldTopAnchor: aboutMeTextFieldTop, endEditing: false, color: .lightGray, fieldTop: 21.0)
            default:
                print("invalid Txtfield")
            }
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            switch textField {
            case firstNameTextField:
                performFloating(with: firstNameLabel, requiredLabel: nil, field: firstNameTextField, topAnchor: firstNameLabelTop, fieldTopAnchor: firstNameTextFieldTop, endEditing: true, color: .lightGray, fieldTop: 21.0)
            case lastNameTextField:
                performFloating(with: lastNameLabel, requiredLabel: nil, field: lastNameTextField, topAnchor: lastNameLabelTop, fieldTopAnchor: lastNameTextFieldTop, endEditing: true, color: .lightGray, fieldTop: 21.0)
            case emailIDTextField:
                performFloating(with: emailIDLabel, requiredLabel: nil, field: emailIDTextField, topAnchor: emailIDLabelTop, fieldTopAnchor: emailIDTextFieldTop, endEditing: true, color: .lightGray, fieldTop: 21.0)
                do {
                    _ = try emailIDTextField.validatedText(validationType: ValidatorType.email,
                                                           visibility: true)
                } catch (let error) {
                    if let messageError = error as? ValidationError {
                        showEmailError(messageError.message)
                    }
                }
            case phoneNumberTextField:
                performFloating(with: phoneNumberLabel, requiredLabel: nil, field: phoneNumberTextField, topAnchor: phoneNumberLabelTop, fieldTopAnchor: phoneNumberTextFieldTop, endEditing: true, color: .lightGray, fieldTop: 21.0)
                do {
                    _ = try phoneNumberTextField.validatedText(validationType: ValidatorType.phone,
                                                               visibility: true)
                } catch (let error) {
                    if let messageError = error as? ValidationError {
                        showPhoneError(messageError.message)
                    }
                }
            case addressTextField:
                performFloating(with: addressLabel, requiredLabel: nil, field: addressTextField, topAnchor: addressLabelTop, fieldTopAnchor: addressTextFieldTop, endEditing: true, color: .lightGray, fieldTop: 21.0)
            case aboutMeTextField:
                performFloating(with: aboutMeLabel, requiredLabel: nil, field: aboutMeTextField, topAnchor: aboutMeLabelTop, fieldTopAnchor: aboutMeTextFieldTop, endEditing: true, color: .lightGray, fieldTop: 21.0)
            default:
                print("invalid Txtfield")
            }
        }
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            switch textField {
            case firstNameTextField:
                if firstNameTextField.text != "" {
                    firstNameTextField.textColor = .lightGray
                    firstNameTextField.borderWidth = 2
                    firstNameError.isHidden = true
                    firstNameTextField.borderColor = .black
                    firstNameLabel.textColor = .lightGray
                    firstNameTextField.leadingImage = nil
                }
            case lastNameTextField:
                if lastNameTextField.text != "" {
                    lastNameTextField.textColor = .lightGray
                    lastNameTextField.borderWidth = 2
                    lastNameErrorLabel.isHidden = true
                    lastNameTextField.borderColor = .black
                    lastNameTextField.textColor = .lightGray
                    lastNameTextField.leadingImage = nil
                }
            case emailIDTextField:
                if emailIDTextField.text != "" {
                    emailIDTextField.textColor = .lightGray
                    emailIDTextField.borderWidth = 2
                    emailIDErrorLabel.isHidden = true
                    emailIDTextField.borderColor = .black
                    emailIDTextField.textColor = .lightGray
                    emailIDTextField.leadingImage = nil
                }
            case phoneNumberTextField:
                if phoneNumberTextField.text != "" {
                    phoneNumberTextField.textColor = .lightGray
                    phoneNumberTextField.borderWidth = 2
                    phoneNumberErrorLabel.isHidden = true
                    phoneNumberTextField.borderColor = .black
                    phoneNumberTextField.textColor = .lightGray
                    phoneNumberTextField.leadingImage = nil
                }
            default:
                print("case is not handled")
            }
            return true
        }
    }
