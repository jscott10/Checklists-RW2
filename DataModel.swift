//
//  DataModel.swift
//  Checklists
//
//  Created by James Scott on 7/21/14.
//  Copyright (c) 2014 jscott10. All rights reserved.
//

import Foundation

class DataModel {
   
    var lists = [Checklist]()
    
    init() {
        loadChecklists()
        registerDefaults()
        handleFirstTime()
    }
    
    func registerDefaults() {
        
//        NSUserDefaults.standardUserDefaults().setInteger(-1, forKey: "ChecklistIndex")
//        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "FirstTime")
        let dictionary = ["ChecklistIndex":-1, "FirstTime": true] as NSDictionary
        
        NSUserDefaults.standardUserDefaults().registerDefaults(dictionary as NSDictionary)
        
    }
    
    func handleFirstTime()  {
        
        let firstTime = NSUserDefaults.standardUserDefaults().boolForKey("FirstTime")
        
        if firstTime    {
            var checklist = Checklist(name: "List")
            lists.append(checklist)
            setIndexOfSelectedChecklist(0)
            NSUserDefaults.standardUserDefaults().setBool(false, forKey: "FirstTime")
        }
    }
    
    func saveChecklists()   {
        var data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
        
        archiver.encodeObject(lists, forKey: "Checklists")
        archiver.finishEncoding()
        data.writeToFile(dataFilePath(), atomically: true)
    }
    
    func loadChecklists()   {
        
        let path = dataFilePath()

        if NSFileManager.defaultManager().fileExistsAtPath(path)  {
            let data = NSData(contentsOfFile: path)
            let unarchiver = NSKeyedUnarchiver(forReadingWithData: data!)
            lists = unarchiver.decodeObjectForKey("Checklists") as [Checklist]
            unarchiver.finishDecoding()
        }
    }
    
    func indexOfSelectedChecklist() -> Int  {
        return NSUserDefaults.standardUserDefaults().integerForKey("ChecklistIndex")
    }
    
    func setIndexOfSelectedChecklist(index: Int)    {
        NSUserDefaults.standardUserDefaults().setInteger(index, forKey: "ChecklistIndex")
    }
    
    func sortChecklists() {
        lists.sort {$0.name < $1.name}
    }
    
    // Helper functions from tutorial
    
    func documentsDirectory() -> String   {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as [String]
        return paths[0]
    }
    
    func dataFilePath() -> String {
        return documentsDirectory().stringByAppendingPathComponent("Checklists.plist")
    }
    
}
