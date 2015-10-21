//
//  CheckItemViewController.swift
//  Checklists
//
//  Created by Ky Nguyen on 8/27/15.
//  Copyright (c) 2015 Ky Nguyen. All rights reserved.
//

import UIKit


protocol CheckItemViewControllerDelegate : class {
    
    func itemDidCancel(controller: CheckItemViewController)
    func itemDidAdd(controller: CheckItemViewController, didFinishAddingItem item: CheckItem)
    func itemDidEdit(controller: CheckItemViewController, didFinishEditingItem item: CheckItem)
}



class CheckItemViewController: UIViewController, UITextFieldDelegate {
    
    var editItem: CheckItem!
    

    
    var remindDate = NSDate()
    
    weak var delegate: CheckItemViewControllerDelegate?
    
    
// Outlet

    @IBOutlet var mainView: UIView!
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    @IBOutlet weak var itemTitle: UITextField!
    
    @IBOutlet weak var remindMe: UISwitch!
    
    @IBOutlet weak var dueDate: UIButton!
  
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    
    
    
// Action
    
    @IBAction func changeRemindMe(sender: UISwitch) {
        
        dueDate.enabled = sender.on
        itemTitle.resignFirstResponder()
    }
    
    @IBAction func showCalendar(sender: AnyObject) {
        
        itemTitle.resignFirstResponder()
        
        datePicker.hidden = !datePicker.hidden
        
        datePicker.date = remindDate
        
        updateDueDate()
    }
    
    @IBAction func cancel(sender: UIButton) {
        
        delegate?.itemDidCancel(self)
    }
    
    @IBAction func done(sender: UIButton) {
        
        if title == StringConstant.EditItemTitle {
            
            doneEditing()
        }
        else {
            
            doneAdding()
        }
    }
    
    @IBAction func selectDueDate(sender: UIDatePicker) {
        
        remindDate = sender.date
        updateDueDate()
    }
    
    
    
    
    
// Override
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setDefaultDate()
        
        itemTitle.becomeFirstResponder()
        itemTitle.addTarget(self, action: Selector("textChanged"), forControlEvents: UIControlEvents.EditingChanged)
        
        if let item = editItem {
            
            enterEditMode(item)
        }
        
        configTapGesture()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
// funcs
    
    func textChanged() {

        doneButton.enabled = itemTitle.text?.characters.count > 0
    }
    
    func updateDueDate() {
        
        let formatter = NSDateFormatter()
        formatter.dateStyle = .MediumStyle
        formatter.timeStyle = .ShortStyle
        dueDate.setTitle(formatter.stringFromDate(remindDate), forState: .Normal)
    }
    
    func configTapGesture() {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: Selector("tapHandler"))
        tapGesture.numberOfTapsRequired = 1
        mainView.addGestureRecognizer(tapGesture)
    }
    
    func tapHandler() {
        
        datePicker.hidden = true
        updateDueDate()
    }
    
    func nextDay(date: NSDate) -> NSDate {
        
        return date.dateByAddingTimeInterval(60*60*24)
    }
    
    func doneEditing() {
        
        editItem.title = itemTitle.text!
        editItem.dueDate = remindDate
        editItem.remindMe = remindMe.on
        
        delegate?.itemDidEdit(self, didFinishEditingItem: editItem)
    }
    
    func doneAdding() {
        
        let item = CheckItem(title: itemTitle.text!)
        item.dueDate = remindDate
        item.remindMe = remindMe.on
        
        delegate?.itemDidAdd(self, didFinishAddingItem: item)
    }
    
    func setDefaultDate() {
        
        remindDate = nextDay(remindDate)
    }
    
    func enterEditMode(item: CheckItem) {
        
        doneButton.enabled = true
        
        title = StringConstant.EditItemTitle
        
        itemTitle.text = item.title
        remindMe.on = item.remindMe
        dueDate.enabled = item.remindMe
        
        configDueDateDisplayer(item.dueDate)
    }
    
    func configDueDateDisplayer(date: NSDate) {
        
        if remindMe.on == false {
            dueDate.setTitle(StringConstant.TapToSet, forState: .Normal)
        }
        else {
            
            remindDate = date
            datePicker.date = remindDate
            
            updateDueDate()
        }

    }
    
    
    
    
    
}
