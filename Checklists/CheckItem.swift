//
//  CheckItem.swift
//  Checklists
//
//  Created by Ky Nguyen on 8/27/15.
//  Copyright (c) 2015 Ky Nguyen. All rights reserved.
//

import Foundation
import UIKit

class CheckItem: NSObject, NSCoding {
    
    var title = ""
    var checked = false
    var dueDate = NSDate()
    var remindMe = false
    var itemId = 0
    
    override init() {
        itemId = DataModel.nextChecklistItemID()
        super.init()
    }
    
    init(title: String) {
        
        itemId = DataModel.nextChecklistItemID()
        self.title = title
        super.init()
    }
    
    func toggleCheck() {
        
        checked = !checked
    }

    required init(coder aDecoder: NSCoder) {
        title = aDecoder.decodeObjectForKey("Title") as! String
        checked = aDecoder.decodeBoolForKey("Checked")
        dueDate = aDecoder.decodeObjectForKey("DueDate") as! NSDate
        remindMe = aDecoder.decodeBoolForKey("RemindMe")
        itemId = aDecoder.decodeIntegerForKey("ItemId")
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(title, forKey: "Title")
        aCoder.encodeBool(checked, forKey: "Checked")
        aCoder.encodeObject(dueDate, forKey: "DueDate")
        aCoder.encodeBool(remindMe, forKey: "RemindMe")
        aCoder.encodeInteger(itemId, forKey: "ItemId")
    }

}