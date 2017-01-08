//
//  customCell.swift
//  Alist
//
//  Created by Thanapat Sorralump on 1/8/17.
//  Copyright © 2017 Thanapat Sorralump. All rights reserved.
//

import UIKit

class customCell: UITableViewCell {

    @IBOutlet weak var taskTopic: UILabel!
    @IBOutlet weak var taskDetail: UILabel!
    @IBOutlet weak var taskType: UIImageView!
    @IBOutlet weak var taskDate: UILabel!
    @IBOutlet weak var taskImportant: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
