//
//  CustomTableViewCell.swift
//  EmployeeDBWithMVVm
//
//  Created by Akash S. Kumar on 05/01/22.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var lastName: UILabel!
    @IBOutlet weak var emailID: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        firstName.attributedText = nil
        lastName.attributedText = nil
        emailID.attributedText = nil
    }
    
    func configureCell(_ employee:Employee) {
        firstName.attributedText = GlobalUtility.customFontString(employee.firstName ?? "", font: UIFont.systemFont(ofSize: 16), color: .black)
        lastName.attributedText = GlobalUtility.customFontString(employee.lastName ?? "", font: UIFont.systemFont(ofSize: 16), color: .black)
        emailID.attributedText = GlobalUtility.customFontString(employee.emailID ?? "", font: UIFont.systemFont(ofSize: 16), color: .black)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
