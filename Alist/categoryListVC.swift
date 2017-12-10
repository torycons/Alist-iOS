//
//  categoryListVC.swift
//  Alist
//
//  Created by Thanapat Sorralump on 4/15/17.
//  Copyright © 2017 Thanapat Sorralump. All rights reserved.
//

import UIKit
import CoreData

class categoryListVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let thonburiFont = UIFont(name: "Thonburi", size: 17)
    var page : String = ""
    var myList : [AnyObject]? = []
    
    @IBOutlet weak var imageTopic: UIImageView!
    @IBOutlet weak var topicLbl: UILabel!
    @IBOutlet weak var categoryTable: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: thonburiFont!, NSAttributedStringKey.foregroundColor: UIColor.white]
        
        // read data from database
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        let myContext = myAppDelegate.persistentContainer.viewContext
        let myFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Tasks")
        myFetchRequest.returnsObjectsAsFaults = false
        
        if page == "Favorite" {
            let myPredicate = NSPredicate(format: "listImportant == true")
            myFetchRequest.predicate = myPredicate
        } else if page == "Personal" {
            let myPredicate = NSPredicate(format: "listType == 'Personal'")
            myFetchRequest.predicate = myPredicate
        } else if page == "Hobby" {
            let myPredicate = NSPredicate(format: "listType == 'Hobby'")
            myFetchRequest.predicate = myPredicate
        } else if page == "Work" {
            let myPredicate = NSPredicate(format: "listType == 'Work'")
            myFetchRequest.predicate = myPredicate
        } else if page == "Other" {
            let myPredicate = NSPredicate(format: "listType == 'Other'")
            myFetchRequest.predicate = myPredicate
        }
        
        do{
            myList = try myContext.fetch(myFetchRequest)
        } catch let error as NSError {
            print(error.description)
        }
        
        self.categoryTable.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Category"
        // Do any additional setup after loading the view.
        
        categoryTable.dataSource = self
        categoryTable.delegate = self
        
        if page == "Favorite" {
            imageTopic.image = UIImage(named: "heartIcon")
            topicLbl.text = "Favorite List Table"
        } else if page == "Personal" {
            imageTopic.image = UIImage(named: "headIcon")
            topicLbl.text = "Personal List Table"
        } else if page == "Hobby" {
            imageTopic.image = UIImage(named: "bookIcon")
            topicLbl.text = "Hobby List Table"
        } else if page == "Work" {
            imageTopic.image = UIImage(named: "workIcon")
            topicLbl.text = "Work List Table"
        } else if page == "Other" {
            imageTopic.image = UIImage(named: "otherIcon")
            topicLbl.text = "Other List Table"
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myList!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! customCategoryCell
        
        let myListTask : NSManagedObject = myList![indexPath.row] as! NSManagedObject
        let myTaskTopic = myListTask.value(forKey: "listTopic") as! String
        let myTaskDetail = myListTask.value(forKey: "listDetail") as! String
        let myTaskDate = myListTask.value(forKey: "listDate") as! String
        let myTaskImportant = myListTask.value(forKey: "listImportant") as! Bool
        
        cell.topicCatCell.text = myTaskTopic
        cell.detailCatCell.text = myTaskDetail
        cell.dateCatCell.text = myTaskDate
        
        if myTaskImportant {
            cell.importantCatCell.image = UIImage(named: "heart-full")
        } else {
            cell.importantCatCell.image = UIImage(named: "heart-blank")
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

}
