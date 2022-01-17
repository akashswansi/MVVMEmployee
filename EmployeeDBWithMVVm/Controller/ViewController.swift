//
//  ViewController.swift
//  EmployeeDBWithMVVm
//
//  Created by Akash S. Kumar on 01/01/22.
//

import UIKit
import MaterialComponents
class ViewController: UIViewController {

    @IBOutlet weak var addEmployeeView: AddEmployeeView!
    @IBAction func showListBtnTapped(_ sender: Any) {
        if let vc = ListViewController.instance() {
            vc.delegate = addEmployeeView
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

