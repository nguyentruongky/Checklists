//
//  ListItemViewController.swift
//  Checklists
//
//  Created by Ky Nguyen on 8/31/15.
//  Copyright (c) 2015 Ky Nguyen. All rights reserved.
//

import UIKit

protocol ListItemViewControllerDelegate: class {
    
    func listItemDidCancel(controller: ListItemViewController)
    func listItemFinishAddingItem(controller: ListItemViewController, item: ListItem)
    func listItemFinishEditingItem(controller: ListItemViewController, item: ListItem)
}

class ListItemViewController: UITableViewController, UITextFieldDelegate, IconPickerViewControllerDelegate {

    weak var delegate: ListItemViewControllerDelegate?

    var editListItem: ListItem?
    var iconName = "No Icon"
    
// outlet
    
    @IBOutlet weak var listTitle: UITextField!
    
    @IBOutlet weak var icon: UIImageView!
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    
    
    
    
    
// action
    
    @IBAction func done(sender: AnyObject) {
        
        
        if title == StringConstant.EditListTitle {
            
            editListItem!.title = listTitle.text!
            editListItem!.icon = iconName
            delegate?.listItemFinishEditingItem(self, item: editListItem!)
        }
        else {
            
            let item = ListItem(title: listTitle.text!)
            item.icon = iconName
            
            delegate?.listItemFinishAddingItem(self, item: item)
        }
    }
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        delegate?.listItemDidCancel(self)
    }
    
    
    
    
// override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listTitle.becomeFirstResponder()
        listTitle.addTarget(self, action: Selector("textChanged"), forControlEvents: UIControlEvents.EditingChanged)
        
        if let item = editListItem {
            
            enterEditMode(item)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == StringConstant.IconPickerId {
            
            findTargetController(segue)
        }
        
    }
    
    
// funcs
    
    func enterEditMode(item: ListItem) {
        
        doneButton.enabled = true
        
        title = StringConstant.EditListTitle
        
        listTitle.text = item.title
        iconName = item.icon
        
        icon.image = UIImage(named: item.icon)

    }
    
    func findTargetController(segue: UIStoryboardSegue) -> IconPickerViewController {
        
        let navigationController = segue.destinationViewController as! UINavigationController
        
        let controller = navigationController.topViewController as! IconPickerViewController
        
        controller.delegate = self
        
        return controller
    }
    
    func textChanged() {
        
        doneButton.enabled = listTitle.text?.characters.count > 0
    }

    func iconPickerDidFinishSelecting(controller: IconPickerViewController, iconName: String) {
        
        icon.image = UIImage(named: iconName)
        self.iconName = iconName

        navigationController!.popViewControllerAnimated(true)
    }
}
