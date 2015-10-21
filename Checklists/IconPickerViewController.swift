//
//  IconPickerViewController.swift
//  Checklists
//
//  Created by Ky Nguyen on 8/31/15.
//  Copyright (c) 2015 Ky Nguyen. All rights reserved.
//

import UIKit

protocol IconPickerViewControllerDelegate: class {
    
    func iconPickerDidFinishSelecting(controller: IconPickerViewController, iconName: String);
}

class IconPickerViewController: UITableViewController {

    weak var delegate: IconPickerViewControllerDelegate!
    
    var icons = [
                "No Icon",
                "Appointments",
                "Birthdays",
                "Chores",
                "Drinks",
                "Folder",
                "Groceries",
                "Inbox",
                "Photos",
                "Trips"
            ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return icons.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(StringConstant.IconId, forIndexPath: indexPath) 

        let iconName = icons[indexPath.row]
        
        cell.imageView?.image = UIImage(named: iconName)
        cell.textLabel?.text = iconName

        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        delegate!.iconPickerDidFinishSelecting(self, iconName: icons[indexPath.row])
    }
}
