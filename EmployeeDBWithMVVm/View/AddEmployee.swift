//
//  AddEmployee.swift
//  EmployeeDBWithMVVm
//
//  Created by Akash S. Kumar on 31/01/22.
//

import UIKit

class AddEmployee: UIView {
    var isEdit:Bool = false
    var dict: DataBaseModel!
    let viewModel = AddEmployeeViewModel()
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var firstNameTextField: DesignableTextField!
    
    @IBOutlet weak var lastNameTextField: DesignableTextField!
    
    @IBOutlet weak var emailIDTextField: DesignableTextField!
    
    @IBOutlet weak var phoneNumberTextField: DesignableTextField!
    
    @IBOutlet weak var addressTextField: DesignableTextField!
    
    @IBOutlet weak var aboutMeTextField: DesignableTextField!
    
    @IBOutlet weak var firstNameLabel: RegisterLabel!
    
    @IBOutlet weak var lastNameLabel: RegisterLabel!
    
    @IBOutlet weak var emailIDLabel: RegisterLabel!
    
    @IBOutlet weak var phoneNumberLabel: RegisterLabel!
   
    @IBOutlet weak var addressLabel: RegisterLabel!
    
    @IBOutlet weak var aboutMeLabel: RegisterLabel!
    
    @IBOutlet weak var firstNameLabelTop: NSLayoutConstraint!
    
    @IBOutlet weak var lastNameLabelTop: NSLayoutConstraint!
    
    @IBOutlet weak var emailIDLabelTop: NSLayoutConstraint!
    
    @IBOutlet weak var phoneNumberLabelTop: NSLayoutConstraint!
    
    @IBOutlet weak var addressLabelTop: NSLayoutConstraint!
    
    @IBOutlet weak var aboutMeLabelTop: NSLayoutConstraint!
    
    @IBOutlet weak var firstNameTextFieldTop: NSLayoutConstraint!
    
    @IBOutlet weak var lastNameTextFieldTop: NSLayoutConstraint!
    
    @IBOutlet weak var emailIDTextFieldTop: NSLayoutConstraint!
    
    @IBOutlet weak var phoneNumberTextFieldTop: NSLayoutConstraint!
    
    @IBOutlet weak var addressTextFieldTop: NSLayoutConstraint!
    
    @IBOutlet weak var aboutMeTextFieldTop: NSLayoutConstraint!
    
    @IBOutlet weak var firstNameError: UILabel!
    
    @IBOutlet weak var lastNameErrorLabel: UILabel!
    
    @IBOutlet weak var emailIDErrorLabel: UILabel!
    
    @IBOutlet weak var phoneNumberErrorLabel: UILabel!
    
    @IBAction func saveBtnTapped(_ sender: Any) {
        self.validateFields()
    }
    
    override func awakeFromNib() {
        registerNotifications()
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
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
        let bundle = Bundle.init(for: AddEmployee.self)
        if let viewToAdd = bundle.loadNibNamed("AddEmployee", owner: self, options: nil), let contenView = viewToAdd.first as? UIView {
            addSubview(contenView)
            contenView.frame = self.bounds
            contenView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            self.isEdit = false
            firstNameTextField.delegate = self
            lastNameTextField.delegate = self
            emailIDTextField.delegate = self
            phoneNumberTextField.delegate = self
            addressTextField.delegate = self
            aboutMeTextField.delegate = self
            setupFloatingUI()
            //addDoneBtn()
        }
    }
   
    func setupFloatingUI() {
        for tf in [firstNameTextField,lastNameTextField, emailIDTextField, phoneNumberTextField, addressTextField, aboutMeTextField] {
            if let txtField = tf {
                if let placeHolder = getPlaceHolder(for: txtField) {
                    txtField.placeHolder(placeHolder, error: false, required: true, color: .red)
                }
            }
            if tf != nil && tf?.text == "" && tf?.isHidden == false {
                
                for fieldTop in [firstNameTextFieldTop, lastNameTextFieldTop, emailIDTextFieldTop, phoneNumberTextFieldTop, addressTextFieldTop, aboutMeTextFieldTop] {
                    if let fieldTop = fieldTop {
                        fieldTop.constant = 21
                    }
                }
                
                for l in [firstNameLabel, lastNameLabel, emailIDLabel, phoneNumberLabel, addressLabel, aboutMeLabel] {
                    l?.float = false
                    l?.isHidden = true
                }
                
                for labelTop in [firstNameLabelTop,lastNameLabelTop, emailIDLabelTop, phoneNumberLabelTop, addressLabelTop, aboutMeLabelTop] {
                    if let labelTop = labelTop {
                        labelTop.constant = 0
                    }
                }
            }
        }
    }
    
    private func getPlaceHolder(for textField:DesignableTextField) -> String? {
        switch textField {
        case firstNameTextField:
            return firstNameLabel.text
        case lastNameTextField:
            return lastNameLabel.text
        case emailIDTextField:
            return emailIDLabel.text
        case phoneNumberTextField:
            return phoneNumberLabel.text
        case addressTextField:
            return addressLabel.text
        case aboutMeTextField:
            return aboutMeLabel.text
        default:
            return nil
        }
    }
    
    func clearTextFields() {
        self.firstNameTextField.becomeFirstResponder()
        phoneNumberTextField.text = ""
        emailIDTextField.text = ""
        firstNameTextField.text = ""
        lastNameTextField.text = ""
        addressTextField.text = ""
        aboutMeTextField.text = ""
        isEdit = false
    }
}
