//
//  webVC.swift
//  Alist
//
//  Created by Thanapat Sorralump on 1/7/17.
//  Copyright © 2017 Thanapat Sorralump. All rights reserved.
//

import UIKit

class webVC: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //edit navigation bar
        self.title = "Alist.com"
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "back")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "back")

        let url = URL(string: "https://camp191.github.io/Alist-Front-End/app/index.html")
        webView.loadRequest(URLRequest(url: url!))
    }
}
