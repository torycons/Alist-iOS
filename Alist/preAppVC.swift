//
//  preAppVC.swift
//  Alist
//
//  Created by Thanapat Sorralump on 1/7/17.
//  Copyright © 2017 Thanapat Sorralump. All rights reserved.
//

import UIKit
import FirebaseAuth

class preAppVC: UIViewController {
  
  @IBOutlet weak var startBtn: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    startBtn.layer.cornerRadius = 8
    
    let user = Auth.auth().currentUser
  }
  
  @IBAction func StartBtn(_ sender: Any) {
    if Auth.auth().currentUser != nil {
      self.performSegue(withIdentifier: "loginDone", sender: self)
    } else {
      self.performSegue(withIdentifier: "notLogin", sender: self)
    }
  }
}

