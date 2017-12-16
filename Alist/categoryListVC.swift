//
//  categoryListVC.swift
//  Alist
//
//  Created by Thanapat Sorralump on 4/15/17.
//  Copyright © 2017 Thanapat Sorralump. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import SVProgressHUD

class categoryListVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  let thonburiFont = UIFont(name: "Thonburi", size: 17)
  var page : String = ""
  var myList : [AnyObject]? = []
  
  let userId = Auth.auth().currentUser?.uid
  var ref: DatabaseReference? = Database.database().reference()
  
  @IBOutlet weak var imageTopic: UIImageView!
  @IBOutlet weak var topicLbl: UILabel!
  @IBOutlet weak var categoryTable: UITableView!
  
  func fetchDataPag(page: String) {
    print("1", page)
    ref?.child("user").child(userId!).observe(.childAdded, with: { (snapshot) in
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
      
      if page == "Favorite" {
        if String(describing: listImportant) == "1" {
          self.myList?.append(aList)
        }
      } else {
        if String(describing: listType) == page {
          self.myList?.append(aList)
        }
      }
      
      self.categoryTable.reloadData()
      SVProgressHUD.dismiss()
    })
    
    ref?.child("user").child(userId!).observe(.value) { (snapshot) in
      if !snapshot.exists(){
        SVProgressHUD.dismiss()
      }
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: thonburiFont!, NSAttributedStringKey.foregroundColor: UIColor.white]
    
    myList = []
    self.categoryTable.reloadData()
    SVProgressHUD.show()
    
    if page == "Favorite" {
      fetchDataPag(page: "Favorite")
    } else if page == "Personal" {
      fetchDataPag(page: "Personal")
    } else if page == "Hobby" {
      fetchDataPag(page: "Hobby")
    } else if page == "Work" {
      fetchDataPag(page: "Work")
    } else if page == "Other" {
      fetchDataPag(page: "Other")
    }

    self.categoryTable.reloadData()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Category"
    
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
    let myTask = myList![indexPath.row]
    
    cell.topicCatCell.text = myTask.listTopic
    cell.detailCatCell.text = myTask.listDetail
    cell.dateCatCell.text = myTask.listDate
    
    if myList![indexPath.row].listImportant {
      cell.importantCatCell.image = UIImage(named: "heart-full")
    } else {
      cell.importantCatCell.image = UIImage(named: "heart-blank")
    }
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    
    if editingStyle == .delete {
      let deleteId = myList![indexPath.row].listKey
      ref?.child("user").child(userId!).child(deleteId!).removeValue { (err, ref) in
        if err != nil {
          print(err!)
        } else {
          self.myList!.remove(at: indexPath.row)
          tableView.deleteRows(at: [indexPath], with: .fade)
        }
      }
    }
  }
  
}
