//
//  addTaskVC.swift
//  Alist
//
//  Created by Thanapat Sorralump on 1/7/17.
//  Copyright © 2017 Thanapat Sorralump. All rights reserved.
//

import UIKit

class addTaskVC: UIViewController {
    
    let thonburiFont = UIFont(name: "Thonburi", size: 17)

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: thonburiFont!, NSForegroundColorAttributeName: UIColor.white]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "เพิ่มการแจ้งเตือนใหม่"
        
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "back")
        
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "back")
    }
    

}
