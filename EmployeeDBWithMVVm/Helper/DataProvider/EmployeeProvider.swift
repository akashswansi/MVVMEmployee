//
//  EmployeeProvider.swift
//  EmployeeDBWithMVVm
//
//  Created by Akash S. Kumar on 12/01/22.
//

import Foundation
import CoreData
class EmployeeProvider {
    
    private weak var fetchedResultControllerDelegate: NSFetchedResultsControllerDelegate?
    init(With fetchedResultControllerDelegate: NSFetchedResultsControllerDelegate) {
        self.fetchedResultControllerDelegate = fetchedResultControllerDelegate
    }
    
    lazy var fetchResultController: NSFetchedResultsController<Employee> = {
        let fetchRequest: NSFetchRequest<Employee> = Employee.fetchRequest()
        fetchRequest.fetchBatchSize = 20
        fetchRequest.sortDescriptors = [NSSortDescriptor(key:"firstName", ascending: true)]
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: DatabaseHelper.sharedInstance.context!, sectionNameKeyPath: nil, cacheName: nil)
        controller.delegate = fetchedResultControllerDelegate

        do{
             try controller.performFetch()
        } catch{
            debugPrint(error)
        }

        return controller
    } ()
}
