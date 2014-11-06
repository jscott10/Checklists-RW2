//
//  ItemDetailViewController.swift
//  Checklists
//
//  Created by James Scott on 7/3/14.
//  Copyright (c) 2014 jscott10. All rights reserved.
//

import UIKit

protocol ItemDetailViewControllerDelegate: class  {
    
    func itemDetailViewControllerDidCancel(controller: ItemDetailViewController)
    
    func itemDetailViewController(controller: ItemDetailViewController, didFinishAddingItem: ChecklistItem)
    
    func itemDetailViewController(controller: ItemDetailViewController, didFinishEditingItem: ChecklistItem)
    
}

class ItemDetailViewController: UITableViewController, UITextFieldDelegate  {
    
//    var delegate: ItemDetailViewControllerDelegate = ChecklistViewController(coder: NSCoder())
    weak var delegate: ItemDetailViewControllerDelegate?
    
    var itemToEdit: ChecklistItem?
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        delegate?.itemDetailViewControllerDidCancel(self)
    }
    
    @IBAction func done(sender: UIBarButtonItem) {
        if let item = itemToEdit    {
            item.text = textField.text
            delegate?.itemDetailViewController(self, didFinishEditingItem: item)
        }
        else    {
            let checklistItem = ChecklistItem()
            checklistItem.text = textField.text
            checklistItem.checked = false
            delegate?.itemDetailViewController(self, didFinishAddingItem: checklistItem)
        }
    }
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        return nil
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange,
        replacementString string: String) -> Bool {
            
            let oldText: NSString = textField.text
            let newText: NSString = oldText.stringByReplacingCharactersInRange(range, withString: string)
            
            doneBarButton.enabled = (newText.length > 0)
            return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let item = itemToEdit    {
            title = "Edit Item"
            textField.text = item.text
            doneBarButton.enabled = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool)    {
        super.viewWillAppear(true)
        textField.becomeFirstResponder()
    }
    
}

