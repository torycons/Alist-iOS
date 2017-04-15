//
//  customCategoryCell.swift
//  Alist
//
//  Created by Thanapat Sorralump on 4/15/17.
//  Copyright © 2017 Thanapat Sorralump. All rights reserved.
//

import UIKit

class customCategoryCell: UITableViewCell {

    @IBOutlet weak var topicCatCell: UILabel!
    @IBOutlet weak var detailCatCell: UILabel!
    @IBOutlet weak var dateCatCell: UILabel!
    @IBOutlet weak var importantCatCell: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
