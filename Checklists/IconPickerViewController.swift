//
//  IconPickerViewController.swift
//  Checklists
//
//  Created by James Scott on 7/29/14.
//  Copyright (c) 2014 jscott10. All rights reserved.
//

import UIKit

class IconPickerViewController: UITableViewController {

    let delegate: IconPickerViewControllerDelegate?
    
    let icons = ["No Icon", "Appointments", "Birthdays", "Chores", "Drinks",
        "Folder", "Groceries", "Inbox", "Photos", "Trips"]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return icons.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell! = tableView.dequeueReusableCellWithIdentifier("IconCell") as UITableViewCell?
        
        let icon = icons[indexPath.row]
        
        cell.textLabel!.text = icon
        cell.imageView!.image = UIImage(named: icon)
        
        return cell
    }

}

protocol IconPickerViewControllerDelegate   {
    
    func iconPicker(picker: IconPickerViewController, didPickIcon iconName: String)
    
}
