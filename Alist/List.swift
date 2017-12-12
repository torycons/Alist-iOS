//
//  List.swift
//  Alist
//
//  Created by Thanapat Sorralump on 13/12/2560 BE.
//  Copyright © 2560 Thanapat Sorralump. All rights reserved.
//

import UIKit

class List: NSObject {
  var listKey: String
  var listDate: String
  var listDetail: String
  var listImportant: Bool
  var listTopic: String
  var listType: String
  
  override init() {
    self.listKey = ""
    self.listDate = ""
    self.listDetail = ""
    self.listImportant = false
    self.listTopic = ""
    self.listType = ""
  }
}
