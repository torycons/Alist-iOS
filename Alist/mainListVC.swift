//
//  mainListVC.swift
//  Alist
//
//  Created by Thanapat Sorralump on 1/7/17.
//  Copyright © 2017 Thanapat Sorralump. All rights reserved.
//

import UIKit
import CoreData

class mainListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var taskListTable: UITableView!

    
    let patuaFont = UIFont(name: "PatuaOne-Regular", size: 20)
    var myList : [AnyObject]? = []
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: patuaFont!, NSAttributedStringKey.foregroundColor: UIColor.white]
        
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        let myContext = myAppDelegate.persistentContainer.viewContext
        let myFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Tasks")
        
        do{
            myList = try myContext.fetch(myFetchRequest)
        } catch let error as NSError {
            print(error.description)
        }
        
        self.taskListTable.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        taskListTable.delegate = self
        taskListTable.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if myList!.count > 0 {
            tabBarController?.tabBar.items?.first?.badgeValue = String(myList!.count)
        } else {
            tabBarController?.tabBar.items?.first?.badgeValue = nil
        }
        
        return myList!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as! customCell
        
        let myListTask : NSManagedObject = myList![indexPath.row] as! NSManagedObject
        let myTaskTopic = myListTask.value(forKey: "listTopic") as! String
        let myTaskDetail = myListTask.value(forKey: "listDetail") as! String
        let myTaskType = myListTask.value(forKey: "listType") as! String
        let myTaskDate = myListTask.value(forKey: "listDate") as! String
        let myTaskImportant = myListTask.value(forKey: "listImportant") as! Bool
        
        cell.taskTopic.text = myTaskTopic
        cell.taskDetail.text = myTaskDetail
        cell.taskDate.text = myTaskDate
        
        if myTaskType == "Work" {
            cell.taskType.image = UIImage(named: "workIcon")
        } else if myTaskType == "Personal" {
            cell.taskType.image = UIImage(named: "headIcon")
        } else if myTaskType == "Hobby" {
            cell.taskType.image = UIImage(named: "bookIcon")
        } else if myTaskType == "Other" {
            cell.taskType.image = UIImage(named: "otherIcon")
        }
        
        if myTaskImportant {
            cell.taskImportant.image = UIImage(named: "heart-full")
        } else {
            cell.taskImportant.image = UIImage(named: "heart-blank")
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        let myContext = myAppDelegate.persistentContainer.viewContext
        
        
        if editingStyle == .delete {
            myContext.delete(myList![indexPath.row] as! NSManagedObject)
            myList!.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            do {
                try myContext.save()
            } catch let error as NSError {
                print(error.description)
            }
        }
    }
    
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
//        let myContext = myAppDelegate.persistentContainer.viewContext
//        
//        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") {action in
//            //handle delete
//            myContext.delete(self.myList![indexPath.row] as! NSManagedObject)
//            self.myList!.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//            
//            do {
//                try myContext.save()
//            } catch let error as NSError {
//                print(error.description)
//            }
//        }
//        
//        let editAction = UITableViewRowAction(style: .normal, title: "Done") {action in
//            //handle edit
//            
//        }
//        
//        return [deleteAction, editAction]
//    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        
    }
}
