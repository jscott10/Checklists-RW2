//
//  AllListsViewController.swift
//  Checklists
//
//  Created by James Scott on 7/12/14.
//  Copyright (c) 2014 jscott10. All rights reserved.
//

import UIKit

class AllListsViewController: UITableViewController, ListDetailViewControllerDelegate, UINavigationControllerDelegate {
    
    var dataModel: DataModel!
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return dataModel.lists.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let CellIdentifier = "Cell"
        
        var cell: UITableViewCell! = tableView.dequeueReusableCellWithIdentifier(CellIdentifier) as? UITableViewCell
        
        if cell == nil  {
            cell = UITableViewCell(style: .Subtitle, reuseIdentifier: CellIdentifier)
        }
        
        var checklist: Checklist = dataModel.lists[indexPath.row]
        
        cell.textLabel.text = checklist.name
        cell.accessoryType = UITableViewCellAccessoryType.DetailDisclosureButton

        let count = checklist.countUncheckedItems()
        
        if checklist.items.count == 0   {
            cell.detailTextLabel!.text = "(No Items)"
        }
        else if count == 0  {
            cell.detailTextLabel!.text = "All Done!"
        }
        else    {
            cell.detailTextLabel!.text = "\(checklist.countUncheckedItems()) Remaining"
        }
        
        cell.imageView.image = UIImage(named: checklist.iconName)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)   {
        
        dataModel!.setIndexOfSelectedChecklist(indexPath.row)
        
        let checklist = dataModel!.lists[indexPath.row]
        performSegueWithIdentifier("ShowChecklist", sender: checklist)
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)   {
        
        dataModel!.lists.removeAtIndex(indexPath.row)

        var indexPaths = [indexPath]
        tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Automatic)        
    }
    
    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath)  {
        
        let navigationController = storyboard!.instantiateViewControllerWithIdentifier("ListNavigationController") as UINavigationController?
        let controller = navigationController!.topViewController as ListDetailViewController
        controller.delegate = self
        let checklist = dataModel!.lists[indexPath.row]
        controller.checklistToEdit = checklist
        presentViewController(navigationController!, animated: true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!)    {
        if segue.identifier == "ShowChecklist"  {
            let controller = segue.destinationViewController as ChecklistViewController
            controller.checklist = sender as? Checklist
        }
        else if segue.identifier == "AddChecklist"  {
            let navigationController = segue.destinationViewController as UINavigationController
            let controller = navigationController.topViewController as ListDetailViewController
            controller.delegate = self
            controller.checklistToEdit = nil
        }
    }
    
    func listDetailViewControllerDidCancel(controller: ListDetailViewController)  {
//        let t = tableView.numberOfRowsInSection(0)
//        println("number of rows: \(t)")
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(true)
        
        navigationController!.delegate = self
        
        let index = dataModel!.indexOfSelectedChecklist()
        
        if index >= 0 && index < dataModel!.lists.count  {
            var checklist = dataModel!.lists[index] as Checklist
            performSegueWithIdentifier("ShowChecklist", sender: checklist)
        }
    }
    
    override func viewWillAppear(animated: Bool)    {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Protocol functions
    
    func listDetailViewController(controller: ListDetailViewController, didFinishAddingChecklist checklist: Checklist)   {

        //TODO: figure out why this keeps the edit-then-add cycle from crashing!
//       let t = tableView.numberOfRowsInSection(0)
//        let newRowIndex = dataModel!.lists.count
        
        dataModel!.lists.append(checklist)
        
//        let indexPath = NSIndexPath(forRow: newRowIndex, inSection: 0)
//        let indexPaths = [indexPath]
        
//        tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Automatic)
        
        dataModel!.sortChecklists()
        tableView.reloadData()
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func listDetailViewController(controller: ListDetailViewController, didFinishEditingChecklist checklist: Checklist)   {
        
//        let index = dataModel!.lists.bridgeToObjectiveC().indexOfObject(checklist)
//        let indexPath = NSIndexPath(forRow: index, inSection: 0)
//        let cell = tableView.cellForRowAtIndexPath(indexPath)
//        cell.textLabel.text = checklist.name
        
        dataModel!.sortChecklists()
        tableView.reloadData()
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func navigationController(navigationController: UINavigationController!, willShowViewController viewController: UIViewController!, animated: Bool)  {
        if viewController == self   {
            println("willShowViewController = self")
            dataModel!.setIndexOfSelectedChecklist(-1)
        }
        else    {
            println("willShowViewController != self")
        }
    }

}
