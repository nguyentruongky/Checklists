//
//  ListItem.swift
//  Checklists
//
//  Created by Ky Nguyen on 8/31/15.
//  Copyright (c) 2015 Ky Nguyen. All rights reserved.
//

import UIKit

class ListItem: NSObject, NSCoding {

    var icon = "No Icon"
    var title = ""
    var items = [CheckItem]()
    
    convenience init(title: String) {

        self.init(title: title, iconName: "No Icon")
    }
    
    init(title: String, iconName: String) {
        self.title = title
        self.icon = iconName
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        title = aDecoder.decodeObjectForKey("Name") as! String
        items = aDecoder.decodeObjectForKey("Items") as! [CheckItem]
        icon = aDecoder.decodeObjectForKey("IconName") as! String
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(title, forKey: "Name")
        aCoder.encodeObject(items, forKey: "Items")
        aCoder.encodeObject(icon, forKey: "IconName")
    }

}