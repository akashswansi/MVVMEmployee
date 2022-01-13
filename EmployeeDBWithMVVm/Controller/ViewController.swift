//
//  ViewController.swift
//  EmployeeDBWithMVVm
//
//  Created by Akash S. Kumar on 01/01/22.
//

import UIKit
import MaterialComponents
class ViewController: UIViewController {

    var isEdit:Bool = false
    var index = Int()
    var dict: DataBaseModel!
    @IBOutlet weak var phoneNumber: MDCOutlinedTextField! {
        didSet {
            phoneNumber.label.text = "Phone Number"
            phoneNumber.placeholder = "555-555-5555"
        }
    }
    
    @IBOutlet weak var emailID: MDCOutlinedTextField!{
        didSet {
            emailID.label.text = "Email ID"
            emailID.placeholder = "example@domain.com"
        }
    }
    @IBOutlet weak var lastName: MDCOutlinedTextField!{
        didSet {
            lastName.label.text = "Last Name"
            lastName.placeholder = "Last Name"
        }
    }
    @IBOutlet weak var firstNameTextField: MDCOutlinedTextField!{
        didSet {
            firstNameTextField.label.text = "First Name"
            firstNameTextField.placeholder = "First Name"
        }
    }
    
    @IBOutlet weak var addressTExtField: MDCOutlinedTextField!{
        didSet {
            addressTExtField.label.text = "Address"
            addressTExtField.placeholder = "Address"
        }
    }
    
    @IBOutlet weak var aboutME: MDCOutlinedTextArea! {
        didSet {
            aboutME.label.text = "About YourSelf"
        }
    }
    
    @IBAction func showListBtnTapped(_ sender: Any) {
        if let vc = ListViewController.instance() {
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    @IBAction func saveBtnTapped(_ sender: WLButton) {
        self.validateFields()
    }
    
    func clearTextFields() {
        phoneNumber.text = ""
        emailID.text = ""
        firstNameTextField.text = ""
        lastName.text = ""
        addressTExtField.text = ""
        aboutME.textView.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isEdit = false
        firstNameTextField.delegate = self
        lastName.delegate = self
        emailID.delegate = self
        phoneNumber.delegate = self
        // Do any additional setup after loading the view.
    }
}

extension ViewController: DataPass {
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
}
