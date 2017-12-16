//
//  mainListVC.swift
//  Alist
//
//  Created by Thanapat Sorralump on 1/7/17.
//  Copyright © 2017 Thanapat Sorralump. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import SVProgressHUD

class mainListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  @IBOutlet weak var taskListTable: UITableView!
  
  let patuaFont = UIFont(name: "PatuaOne-Regular", size: 20)
  let userId = Auth.auth().currentUser?.uid
  var ref: DatabaseReference! = Database.database().reference()
  var myList : [AnyObject]? = []
  
  override func viewWillAppear(_ animated: Bool) {
    self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: patuaFont!, NSAttributedStringKey.foregroundColor: UIColor.white]
    
    SVProgressHUD.show()
    myList = []
    self.taskListTable.reloadData()
    
    ref.child("user").child(userId!).observe(.childAdded) { (snapshot) in
      let mySnapshotValue = snapshot.value as! Dictionary<String, Any>
      let listDate = mySnapshotValue["listDate"]!
      let listDetail = mySnapshotValue["listDetail"]!
      let listImportant = mySnapshotValue["listImportant"]!
      let listTopic = mySnapshotValue["listTopic"]!
      let listType = mySnapshotValue["listType"]!
      
      let aList = List()
      aList.listTopic = listTopic as! String
      aList.listDetail = listDetail as! String
      aList.listImportant = listImportant as! Bool
      aList.listDate = listDate as! String
      aList.listType = listType as! String
      aList.listKey = snapshot.key
      
      self.myList?.append(aList)
      
      SVProgressHUD.dismiss()
      self.taskListTable.reloadData()
    }
    
    ref.child("user").child(userId!).observe(.value) { (snapshot) in
      if !snapshot.exists(){
        SVProgressHUD.dismiss()
      }
    }
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
    let myTask = myList![indexPath.row]
    
    cell.taskTopic.text = myTask.listTopic
    cell.taskDetail.text = myTask.listDetail
    cell.taskDate.text = myTask.listDate

    let myTaskType = myTask.listType
    
    if myTaskType == "Work" {
      cell.taskType.image = UIImage(named: "workIcon")
    } else if myTaskType == "Personal" {
      cell.taskType.image = UIImage(named: "headIcon")
    } else if myTaskType == "Hobby" {
      cell.taskType.image = UIImage(named: "bookIcon")
    } else if myTaskType == "Other" {
      cell.taskType.image = UIImage(named: "otherIcon")
    }

    if myList![indexPath.row].listImportant {
      cell.taskImportant.image = UIImage(named: "heart-full")
    } else {
      cell.taskImportant.image = UIImage(named: "heart-blank")
    }

    return cell
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      let deleteId = myList![indexPath.row].listKey
      ref.child("user").child(userId!).child(deleteId!).removeValue { (err, ref) in
        if err != nil {
          print(err!)
        } else {
          self.myList!.remove(at: indexPath.row)
          tableView.deleteRows(at: [indexPath], with: .fade)
        }
      }
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let backItem = UIBarButtonItem()
    backItem.title = ""
    navigationItem.backBarButtonItem = backItem
  }
}
