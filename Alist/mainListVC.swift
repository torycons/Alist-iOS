//
//  mainListVC.swift
//  Alist
//
//  Created by Thanapat Sorralump on 1/7/17.
//  Copyright © 2017 Thanapat Sorralump. All rights reserved.
//

import UIKit

class mainListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var taskListTable: UITableView!
    let patuaFont = UIFont(name: "PatuaOne-Regular", size: 20)
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: patuaFont!, NSForegroundColorAttributeName: UIColor.white]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        taskListTable.delegate = self
        taskListTable.dataSource = self

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }
}
