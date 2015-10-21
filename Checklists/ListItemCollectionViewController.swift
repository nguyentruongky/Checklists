//
//  ListCollectionViewController.swift
//  Checklists
//
//  Created by Ky Nguyen on 8/31/15.
//  Copyright (c) 2015 Ky Nguyen. All rights reserved.
//

import UIKit

class ListItemCollectionViewController: UITableViewController, ListItemViewControllerDelegate {

    var itemIndex = -1
    
    var dataModel = DataModel()
    
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

        return dataModel.listItems.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier(StringConstant.ListItemId, forIndexPath: indexPath)

        cell.textLabel?.text = dataModel.listItems[indexPath.row].title
        cell.imageView?.image = UIImage(named: dataModel.listItems[indexPath.row].icon)
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if segue.identifier == StringConstant.ListItemIdentifier {
            
            findTargetController(segue)
        }
        else if segue.identifier == StringConstant.EditChecklist {
            
            let controller = findTargetController(segue)
            
            if let indexPath = tableView.indexPathForCell(sender as! UITableViewCell) {
                
                itemIndex = indexPath.row
                controller.editListItem = dataModel.listItems[indexPath.row]
            }

        }
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {

        if editingStyle == .Delete {
            
            dataModel.listItems.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }

    func findTargetController(segue: UIStoryboardSegue) -> ListItemViewController {
        
        let navigationController = segue.destinationViewController as! UINavigationController
        
        let controller = navigationController.topViewController as! ListItemViewController
        
        controller.delegate = self
        
        return controller
    }
    
    func listItemFinishAddingItem(controller: ListItemViewController, item: ListItem) {
        
        addListItem(item)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func listItemDidCancel(controller: ListItemViewController) {

        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func listItemFinishEditingItem(controller: ListItemViewController, item: ListItem) {
        
        
        if itemIndex != -1 {
            
            let indexPath = NSIndexPath(forRow: itemIndex, inSection: 0)
            
            if let cell = tableView.cellForRowAtIndexPath(indexPath) {
                
                cell.textLabel?.text = item.title
                cell.imageView?.image = UIImage(named: item.icon)
            }
            
            itemIndex = -1
        }

        dismissViewControllerAnimated(true, completion: nil)
    }

    func addListItem(listItem: ListItem) {
        
        let indexPath = NSIndexPath(forRow: dataModel.listItems.count, inSection:0)
        
        dataModel.listItems.append(listItem)
        
        tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }

}
