//
//  aboutVC.swift
//  Alist
//
//  Created by Thanapat Sorralump on 1/7/17.
//  Copyright © 2017 Thanapat Sorralump. All rights reserved.
//

import UIKit
import CoreData

class aboutVC: UIViewController {
    
    let thonburiFont = UIFont(name: "Thonburi", size: 17)
    var myListTask : NSManagedObject?
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: thonburiFont!, NSForegroundColorAttributeName: UIColor.white]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func deleteAll(_ sender: Any) {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        let myContext = myAppDelegate.persistentContainer.viewContext
        let myFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Tasks")
        let deleteAllData = NSBatchDeleteRequest(fetchRequest: myFetchRequest)
        
        tabBarController?.tabBar.items?.first?.badgeValue = nil
        
        do {
            try myContext.execute(deleteAllData)
        } catch let error as NSError {
            print(error.description + ": Can't delete all of data")
        }
        
    }
    

}
