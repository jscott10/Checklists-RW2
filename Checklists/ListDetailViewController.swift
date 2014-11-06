//
//  ListDetailViewController.swift
//  Checklists
//
//  Created by James Scott on 7/15/14.
//  Copyright (c) 2014 jscott10. All rights reserved.
//

import UIKit

protocol ListDetailViewControllerDelegate: class  {
    
    func listDetailViewControllerDidCancel(controller: ListDetailViewController)
    
    func listDetailViewController(controller: ListDetailViewController, didFinishAddingChecklist checklist: Checklist)
    
    func listDetailViewController(controller: ListDetailViewController, didFinishEditingChecklist checklist: Checklist)
    
}

class ListDetailViewController: UITableViewController, UITextFieldDelegate {
    
//    class ListDetailViewController: UITableViewController, UITextFieldDelegate, IconPickerViewControllerDelegate {
        
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    //    weak var delegate: ListDetailViewControllerDelegate = AllListsViewController(coder: NSCoder())    
    weak var delegate: ListDetailViewControllerDelegate?
    
    var checklistToEdit:Checklist?
    
    var iconName = ""
    
//    convenience required init(coder aDecoder: NSCoder) {
//       self.init(coder: aDecoder)
//        iconName = "Folder"
//    }
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        delegate?.listDetailViewControllerDidCancel(self)
    }
    
    @IBAction func done(sender: UIBarButtonItem) {
        if let checklist = checklistToEdit    {
            checklist.name = textField!.text
            delegate?.listDetailViewController(self, didFinishEditingChecklist: checklist)
        }
        else    {
            let checklist = Checklist(name: textField!.text)
            delegate?.listDetailViewController(self, didFinishAddingChecklist: checklist)
        }
    }
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        if indexPath.section == 1   {
            return indexPath
        }
        else    {
            return nil
        }
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
        if let checklist = checklistToEdit  {
            title = "Edit Checklist"
            textField!.text = checklist.name
            doneBarButton!.enabled = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool)    {
        textField!.becomeFirstResponder()
        super.viewWillAppear(animated)
    }

}

