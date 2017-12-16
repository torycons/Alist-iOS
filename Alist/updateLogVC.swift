//
//  updateLogVC.swift
//  Alist
//
//  Created by Thanapat Sorralump on 1/13/17.
//  Copyright © 2017 Thanapat Sorralump. All rights reserved.
//

import UIKit

class updateLogVC: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //edit navigation bar
    self.title = "Update Log"
    self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "back")
    self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "back")
  }
}
