//
//  DataModel.swift
//  Checklists
//
//  Created by Ky Nguyen on 9/1/15.
//  Copyright (c) 2015 Ky Nguyen. All rights reserved.
//

import Foundation

class DataModel {
    
    var listItems = [ListItem]()
    
    init() {
        loadChecklists()
        registerDefaults()
    }
    
    func documentsDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) 
        return paths[0]
    }
    
    func dataFilePath() -> String {
        
        return NSString(string: documentsDirectory()).stringByAppendingPathComponent(StringConstant.databaseName)
    }
    
    func saveChecklists() {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
        archiver.encodeObject(listItems, forKey: StringConstant.Checklists)
        archiver.finishEncoding()
        data.writeToFile(dataFilePath(), atomically: true)
    }
    
    func loadChecklists() {
        let path = dataFilePath()
        if NSFileManager.defaultManager().fileExistsAtPath(path) {
            if let data = NSData(contentsOfFile: path) {
                let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
                listItems = unarchiver.decodeObjectForKey(StringConstant.Checklists) as! [ListItem]
                unarchiver.finishDecoding()
            }
        }
    }
    
    func registerDefaults() {
        let dictionary = [ StringConstant.ChecklistIndex: -1,
            StringConstant.FirstTime: true,
            StringConstant.CheckItemID: 0 ]
        
        NSUserDefaults.standardUserDefaults().registerDefaults(dictionary)
    }
    
    var indexOfSelectedChecklist: Int {
        get {
            return NSUserDefaults.standardUserDefaults().integerForKey(StringConstant.ChecklistIndex)
        }
        set {
            NSUserDefaults.standardUserDefaults().setInteger(newValue, forKey: StringConstant.ChecklistIndex)
        }
    }
    
    func handleFirstTime() {
        _ = NSUserDefaults.standardUserDefaults()
//        let firstTime = userDefaults.boolForKey(StringConstant.FirstTime)
//        if firstTime {
//            let checklist = CheckItem(title: "List")
//            listItems.append(checklist)
//            indexOfSelectedChecklist = 0
//            userDefaults.setBool(false, forKey: StringConstant.FirstTime)
//        }
    }
    
    class func nextChecklistItemID() -> Int {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let itemID = userDefaults.integerForKey(StringConstant.CheckItemID)
        userDefaults.setInteger(itemID + 1, forKey: StringConstant.CheckItemID)
        userDefaults.synchronize()
        return itemID
    }

}