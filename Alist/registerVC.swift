//
//  registerVC.swift
//  Alist
//
//  Created by Thanapat Sorralump on 11/12/2560 BE.
//  Copyright © 2560 Thanapat Sorralump. All rights reserved.
//

import UIKit
import FirebaseAuth

class registerVC: UIViewController {
  
  @IBOutlet weak var email: UITextField!
  @IBOutlet weak var password: UITextField!
  @IBOutlet weak var registerBtn: UIButton!
    
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    registerBtn.layer.cornerRadius = 8
    email.borderStyle = UITextBorderStyle.roundedRect
    password.borderStyle = UITextBorderStyle.roundedRect
  }
  
  @IBAction func goToLoginPage(_ sender: Any) {
    self.performSegue(withIdentifier: "unwindToRoot", sender: self)
  }
  
  @IBAction func register(_ sender: Any) {
    Auth.auth().createUser(withEmail: email.text!, password: password.text!) { (user, error) in
      if error != nil {
        let errorAlert = UIAlertController(title: "พบข้อผิดพลาด", message: error?.localizedDescription, preferredStyle: .alert)
        errorAlert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { (action) in
          self.password.text = ""
        }))
        
        self.present(errorAlert, animated: true, completion: nil)
        
      } else {
        let registerAlert = UIAlertController(title: "สมัครเรียบร้อย", message: "สมัครใช้งาน Alist เรียบร้อยแล้ว คุณสามารถใช้งานได้ทันที", preferredStyle: .alert)
        registerAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
          self.email.text = ""
          self.password.text = ""
          self.performSegue(withIdentifier: "registerUse", sender: self)
        }))
        
        self.present(registerAlert, animated: true, completion: nil)
      }
    }
  }
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
}
