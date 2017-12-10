//
//  categoryVC.swift
//  Alist
//
//  Created by Thanapat Sorralump on 4/15/17.
//  Copyright © 2017 Thanapat Sorralump. All rights reserved.
//

import UIKit

class categoryVC: UITableViewController {
    
    let thonburiFont = UIFont(name: "Thonburi", size: 17)
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: thonburiFont!, NSAttributedStringKey.foregroundColor: UIColor.white]
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        
        if segue.identifier == "favorite" {
            
            let categoryList = segue.destination as! categoryListVC
            categoryList.page = "Favorite"
            
        } else if segue.identifier == "personal" {

            let categoryList = segue.destination as! categoryListVC
            categoryList.page = "Personal"
            
        } else if segue.identifier == "hobby" {
            
            let categoryList = segue.destination as! categoryListVC
            categoryList.page = "Hobby"
            
        } else if segue.identifier == "work" {
            
            let categoryList = segue.destination as! categoryListVC
            categoryList.page = "Work"
            
        } else if segue.identifier == "other" {
            
            let categoryList = segue.destination as! categoryListVC
            categoryList.page = "Other"
            
        }
    }


}
