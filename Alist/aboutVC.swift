//
//  aboutVC.swift
//  Alist
//
//  Created by Thanapat Sorralump on 1/7/17.
//  Copyright © 2017 Thanapat Sorralump. All rights reserved.
//

import UIKit

class aboutVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var categoriesTable: UITableView!
    let thonburiFont = UIFont(name: "Thonburi", size: 17)
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: thonburiFont!, NSForegroundColorAttributeName: UIColor.white]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoriesTable.delegate = self
        categoriesTable.dataSource = self


        // Do any additional setup after loading the view.
    }

    

}
