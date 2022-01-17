//
//  AddEmployeeView.swift
//  EmployeeDBWithMVVm
//
//  Created by Akash S. Kumar on 16/01/22.
//

import Foundation
import UIKit
import MaterialComponents

class AddEmployeeView: UIView {
    var isEdit:Bool = false
    var index = Int()
    var dict: DataBaseModel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var phoneNumber: MDCOutlinedTextField! {
        didSet {
            phoneNumber.label.text = "* Phone Number"
            phoneNumber.placeholder = "555-555-5555"
        }
    }
    
    @IBOutlet weak var emailID: MDCOutlinedTextField!{
        didSet {
            emailID.label.text = "* Email ID"
            emailID.placeholder = "example@domain.com"
        }
    }
    @IBOutlet weak var lastName: MDCOutlinedTextField!{
        didSet {
            lastName.label.text = "* Last Name"
            lastName.placeholder = "Last Name"
        }
    }
    @IBOutlet weak var firstNameTextField: MDCOutlinedTextField!{
        didSet {
            firstNameTextField.label.text = "* First Name"
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
    
    
    @IBAction func saveBtnTapped(_ sender: WLButton) {
        self.validateFields()
    }
    
    override func awakeFromNib() {
        registerNotifications() 
    }
    func clearTextFields() {
        self.firstNameTextField.becomeFirstResponder()
        phoneNumber.text = ""
        emailID.text = ""
        firstNameTextField.text = ""
        lastName.text = ""
        addressTExtField.text = ""
        aboutME.textView.text = ""
    }
    
    
    //MARK:
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        loadViewFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        loadViewFromNib()
    }
    
    //MARK:
    func loadViewFromNib() {
        let bundle = Bundle.init(for: AddEmployeeView.self)
        if let viewToAdd = bundle.loadNibNamed("AddEmployeeView", owner: self, options: nil), let contenView = viewToAdd.first as? UIView {
            addSubview(contenView)
            contenView.frame = self.bounds
            contenView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            self.isEdit = false
            firstNameTextField.delegate = self
            lastName.delegate = self
            emailID.delegate = self
            phoneNumber.delegate = self
            addDoneBtn()
        }
    }
    
    func createImageView() -> UIImageView {
        let imageView = UIImageView(image:UIImage(named: "error"))
        imageView.frame = CGRect(x: 0, y: 0, width: 40, height: 20)
        return imageView
    }
}
