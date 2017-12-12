//
//  LoginVC.swift
//  Alist
//
//  Created by Thanapat Sorralump on 11/12/2560 BE.
//  Copyright © 2560 Thanapat Sorralump. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginVC: UIViewController {
  
  @IBOutlet weak var emailLogin: UITextField!
  @IBOutlet weak var passwordLogin: UITextField!
  @IBOutlet weak var loginBtn: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    self.loginBtn.layer.cornerRadius = 8
    self.emailLogin.borderStyle = UITextBorderStyle.roundedRect
    self.passwordLogin.borderStyle = UITextBorderStyle.roundedRect
  }
  
  @IBAction func login(_ sender: Any) {
    Auth.auth().signIn(withEmail: emailLogin.text!, password: passwordLogin.text!) { (user, error) in
      if error != nil {
        let errorAlert = UIAlertController(title: "พบความผิดพลาด", message: error?.localizedDescription, preferredStyle: .alert)
        errorAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (done) in
          self.passwordLogin.text = ""
          self.emailLogin.text = ""
        }))
        
        self.present(errorAlert, animated: true, completion: nil)
      } else {
        self.emailLogin.text = ""
        self.passwordLogin.text = ""
        self.performSegue(withIdentifier: "login", sender: self)
      }
    }
  }
  
  @IBAction func unwindToRoot(segue:UIStoryboardSegue) {
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
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
