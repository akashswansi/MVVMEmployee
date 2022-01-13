//
//  ListViewController.swift
//  EmployeeDBWithMVVm
//
//  Created by Akash S. Kumar on 12/01/22.
//

import UIKit
import CoreData
class ListViewController: UIViewController {
    
    weak var delegate:DataPass?
    
    lazy var employeeDataProvider: EmployeeProvider =
   {
       let dataProvider = EmployeeProvider(With: self)
       return dataProvider
   }()
    
    @IBOutlet weak var searchBar: UISearchBar!
    fileprivate let viewModel = ViewControllerViewModel()
    
    private var employee = [Employee]()
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.separatorStyle = .none
            tableView.rowHeight = UITableView.automaticDimension
            tableView.estimatedRowHeight = 100
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = viewModel
        tableView.delegate = viewModel
        let bundle = Bundle(for: type(of: self))
        self.tableView.register(UINib(nibName: "CustomTableViewCell", bundle: bundle), forCellReuseIdentifier: "CustomTableViewCell")
        employee = employeeDataProvider.fetchResultController.fetchedObjects ?? []
        self.viewModel.refreshWith(data: employee, {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
      //
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(self.deleteRow(userInfo:)), name: Notification.Name("DeleteRow"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateRow(notification:)), name: Notification.Name("UpdateRow"), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: Notification.Name("DeleteRow"), object: nil)
        NotificationCenter.default.removeObserver(self, name: Notification.Name("UpdateRow"), object: nil)
    }
    
    @objc func deleteRow(userInfo: NSNotification) {
        if let indexPath = userInfo.userInfo?["indexPath"] as? IndexPath {
        employee = DatabaseHelper.sharedInstance.deleteData(indexPath.row)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    @objc func updateRow(notification:NSNotification) {
        if let model = notification.userInfo?["databaseModel"]  as? [Int:DataBaseModel]{
            for (key,value) in model {
                self.delegate?.data(object: value, index: key)
                self.navigationController?.popViewController(animated: true)
                return
            }
        }
    }
    
    class func instance() -> ListViewController? {
        return StoryBoard.Main.board.instantiateViewController(withIdentifier: AppClass.ListVC.rawValue) as? ListViewController
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ListViewController : NSFetchedResultsControllerDelegate, UISearchBarDelegate
{
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            employee = DatabaseHelper.sharedInstance.fetchSearchedData(searchStr: searchText)
            self.viewModel.refreshWith(data: employee, {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            })
        } else {
            employee = employeeDataProvider.fetchResultController.fetchedObjects ?? []
            self.viewModel.refreshWith(data: employee, {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            })
        }
    }
}
