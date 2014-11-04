//
//  ChecklistViewController.swift
//  Checklists
//
//  Created by James Scott on 6/18/14.
//  Copyright (c) 2014 jscott10. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController, ItemDetailViewControllerDelegate {
    
    var checklist: Checklist?
    
    var items = [ChecklistItem]()

    required init(coder aDecoder: NSCoder)  {
        super.init(coder: aDecoder)
//        println(documentsDirectory())
//        loadChecklistItems()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int    {
        return checklist!.items.count
    }
    
    func configureTextForCell(cell: UITableViewCell, withChecklistItem item: ChecklistItem)    {
        let label = cell.viewWithTag(1000) as UILabel
        label.text = item.text
    }
    
    func configureCheckmarkForCell(cell: UITableViewCell, withChecklistItem item: ChecklistItem)   {
        
        var label = cell.viewWithTag(1001) as UILabel

        if item.checked    {
            label.text = "√"
//            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        }
        else    {
            label.text = ""
//            cell.accessoryType = UITableViewCellAccessoryType.None
        }
    }
    
    override func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell     {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("ChecklistItem") as UITableViewCell
        var item = checklist!.items[indexPath.row]
        configureTextForCell(cell, withChecklistItem: item)
        configureCheckmarkForCell(cell,  withChecklistItem: item)
        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if let cell = tableView.cellForRowAtIndexPath(indexPath)    {
            var item = checklist!.items[indexPath.row]
            item.toggleChecked()
            configureCheckmarkForCell(cell,  withChecklistItem: item)
//          saveChecklistItems()
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)   {
        
        checklist!.items.removeAtIndex(indexPath.row)
//        saveChecklistItems()
        var indexPaths = [indexPath]
        tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Automatic)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!)     {
        if segue.identifier == "AddItem"    {
            let navigationController = segue.destinationViewController as UINavigationController
            let controller = navigationController.topViewController as ItemDetailViewController
            controller.delegate = self
        }
        else if segue.identifier == "EditItem"  {
            let navigationController = segue.destinationViewController as UINavigationController
            let controller = navigationController.topViewController as ItemDetailViewController
            controller.delegate = self
            if let indexPath = tableView.indexPathForCell(sender as UITableViewCell)    {
                controller.itemToEdit = checklist!.items[indexPath.row]
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = checklist!.name
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Protocol functions
    
    func itemDetailViewControllerDidCancel(controller: ItemDetailViewController)  {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func itemDetailViewController(controller: ItemDetailViewController, didFinishAddingItem item: ChecklistItem)   {
        
        //TODO: figure out why this keeps the edit-then-add cycle from crashing!
        let t = tableView.numberOfRowsInSection(0)
        
        let newRowIndex = checklist!.items.count
        checklist!.items.append(item)
        let indexPath = NSIndexPath(forRow: newRowIndex, inSection: 0)
        let indexPaths = [indexPath]
        tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Automatic)
//        saveChecklistItems()
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func itemDetailViewController(controller: ItemDetailViewController, didFinishEditingItem item: ChecklistItem)   {        
        
        let index = find(checklist!.items, item)
        
        let indexPath = NSIndexPath(forRow: index!, inSection: 0)
        if let cell = tableView.cellForRowAtIndexPath(indexPath)    {
            configureTextForCell(cell, withChecklistItem: item)
        }
//        saveChecklistItems()
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}

