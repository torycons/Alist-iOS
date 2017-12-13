//
//  settingVC.swift
//  Alist
//
//  Created by Thanapat Sorralump on 1/11/17.
//  Copyright © 2017 Thanapat Sorralump. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class settingVC: UITableViewController {
  
  @IBOutlet weak var username: UILabel!
  
  let thonburiFont = UIFont(name: "Thonburi", size: 17)
  var ref: DatabaseReference! = Database.database().reference()
  let user = Auth.auth().currentUser
  
  override func viewWillAppear(_ animated: Bool) {
    self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: thonburiFont!, NSAttributedStringKey.foregroundColor: UIColor.white]
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    username.text = user?.email
  }
  
  @IBAction func deleteAllBtn(_ sender: Any) {
    
    // alert if don't insert every text field
    let alert = UIAlertController(title: "ลบข้อมูลทั้งหมด", message: "คุณต้องการลบข้อมูลรายการที่ต้องทำทั้งหมดหรือไม่", preferredStyle: UIAlertControllerStyle.alert)
    
    alert.addAction(UIAlertAction(title: "ใช่", style: UIAlertActionStyle.cancel, handler: { action in
      self.ref.child("user").child((self.user?.uid)!).removeValue()
      self.tabBarController?.tabBar.items?.first?.badgeValue = nil
    }))
    
    alert.addAction(UIAlertAction(title: "ยกเลิก", style: UIAlertActionStyle.default, handler: nil))
    
    self.present(alert, animated: true, completion: nil)
  }
  
  @IBAction func logout(_ sender: Any) {
    let alertLogout = UIAlertController(title: "ออกจากระบบ", message: "คุณต้องการออกจากระบบหรือไม่", preferredStyle: .alert)
    
    alertLogout.addAction(UIAlertAction(title: "ไม่", style: .default, handler: nil))
    
    alertLogout.addAction(UIAlertAction(title: "ใช่", style: .cancel, handler: { (action) in
      let firebaseAuth = Auth.auth()
      try! firebaseAuth.signOut()
      self.performSegue(withIdentifier: "unwindToPreApp", sender: self)
    }))
    
    self.present(alertLogout, animated: true, completion: nil)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let backItem = UIBarButtonItem()
    backItem.title = ""
    navigationItem.backBarButtonItem = backItem
  }
  
}
