//
//  ChecklistViewController.swift
//  Checklists
//
//  Created by Ky Nguyen on 8/27/15.
//  Copyright (c) 2015 Ky Nguyen. All rights reserved.
//

// 100: title
// 101: checkmark

import UIKit

class ChecklistViewController: UITableViewController, CheckItemViewControllerDelegate {

    var editItemIndex = -1
    var items = [CheckItem]()
    
    required init!(coder aDecoder: NSCoder) {

        super.init(coder: aDecoder)
    }
    
    
    
    
// override
    
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

        return items.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(StringConstant.checkItem, forIndexPath: indexPath)

        configureTitle(cell, indexPath: indexPath)

        configureCheckmark(cell, indexPath: indexPath)
        
        return cell
    }

    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
        items[indexPath.row].toggleCheck()
        
        let cell = tableView.cellForRowAtIndexPath(indexPath)

        configureCheckmark(cell!, indexPath: indexPath)
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == StringConstant.AddItemIdentifier {
            
            findTargetController(segue)
        }
        else if segue.identifier == StringConstant.EditItemIdentifier {
            
            let controller = findTargetController(segue)
            
            if let indexPath = tableView.indexPathForCell(sender as! UITableViewCell) {
                
                editItemIndex = indexPath.row
                controller.editItem = items[indexPath.row]
            }
        }
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {

            items.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    
    

    
    
    
    
    
    
    
    
    
    
    
// funcs
    
    func findTargetController(segue: UIStoryboardSegue) -> CheckItemViewController {
        
        let navigationController = segue.destinationViewController as! UINavigationController
        
        let controller = navigationController.topViewController as! CheckItemViewController
        
        controller.delegate = self
        
        return controller
    }
    
    func addItem(item: CheckItem) {

        let indexPath = NSIndexPath(forRow: items.count, inSection:0)

        items.append(item)
        
        tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }
    
    func configureCheckmark(cell: UITableViewCell, indexPath: NSIndexPath) {
        
        let itemCheckmark = cell.viewWithTag(TagConstant.ItemCheckmark) as! UILabel
        
        if items[indexPath.row].checked == true {
            
            itemCheckmark.text = "✅"
        }
        else {
            
            itemCheckmark.text = ""
        }
    }

    func configureTitle(cell: UITableViewCell, indexPath: NSIndexPath) {
        
        let itemTitle = cell.viewWithTag(TagConstant.ItemTitle) as! UILabel
        itemTitle.text = items[indexPath.row].title
    }
    
    func itemDidCancel(controller: CheckItemViewController) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func itemDidAdd(controller: CheckItemViewController, didFinishAddingItem item: CheckItem) {
        
        addItem(item)
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func itemDidEdit(controller: CheckItemViewController, didFinishEditingItem item: CheckItem) {
        
        if editItemIndex != -1 {
            
            let indexPath = NSIndexPath(forRow: editItemIndex, inSection: 0)
            
            if let cell = tableView.cellForRowAtIndexPath(indexPath) {
                
                configureTitle(cell, indexPath: indexPath)
            }
            
            editItemIndex = -1
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the specified item to be editable.
    return true
    }
    */
    
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the item to be re-orderable.
    return true
    }
    */
    


}
