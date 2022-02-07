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
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.separatorStyle = .none
            tableView.rowHeight = UITableView.automaticDimension
            tableView.estimatedRowHeight = 100
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        initViewModel()
        let bundle = Bundle(for: type(of: self))
        self.tableView.register(UINib(nibName: "CustomTableViewCell", bundle: bundle), forCellReuseIdentifier: "CustomTableViewCell")
      //
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    
    class func instance() -> ListViewController? {
        return StoryBoard.Main.board.instantiateViewController(withIdentifier: AppClass.ListVC.rawValue) as? ListViewController
    }
    
    func initViewModel() {
        viewModel.reloadTableView = {
            DispatchQueue.main.async { self.tableView.reloadData() }
        }
        viewModel.setCellViewModel(employeeDataProvider.fetchResultController.fetchedObjects ?? [])
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

extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if let tmp = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as? CustomTableViewCell {
            tmp.configureCell(viewModel.getCellViewModel(at: indexPath))
            cell = tmp
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        switch editingStyle {
        case .delete:
            viewModel.setCellViewModel(DatabaseHelper.sharedInstance.deleteData(viewModel.getCellViewModel(at: indexPath)))
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        default:
            print("case is not handled")
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dict = DataBaseModel(firstName: viewModel.getCellViewModel(at: indexPath).firstName ?? "", lastName: viewModel.getCellViewModel(at: indexPath).lastName ?? "", emailID: viewModel.getCellViewModel(at: indexPath).emailID ?? "", phoneNumber: viewModel.getCellViewModel(at: indexPath).phoneNumber ?? "", address: viewModel.getCellViewModel(at: indexPath).address, aboutYou: viewModel.getCellViewModel(at: indexPath).aboutYou)
        delegate?.data(object: dict, employee: viewModel.getCellViewModel(at: indexPath))
        self.navigationController?.popViewController(animated: true)
    }
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
            viewModel.setCellViewModel(DatabaseHelper.sharedInstance.fetchSearchedData(searchStr: searchText))
        } else {
            viewModel.setCellViewModel(employeeDataProvider.fetchResultController.fetchedObjects ?? [])
            
        }
    }
}
