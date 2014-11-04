//
//  DataModel.swift
//  Checklists
//
//  Created by James Scott on 7/21/14.
//  Copyright (c) 2014 jscott10. All rights reserved.
//

import UIKit

class DataModel {
   
    var lists = [Checklist]()
    
    func registerDefaults() {
//        NSUserDefaults.standardUserDefaults().setInteger(-1, forKey: "ChecklistIndex")
//        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "FirstTime")
        let dictionary = ["ChecklistIndex":-1, "FirstTime": true] as NSDictionary
        
        var xxx = dictionary["FirstTime"] as Bool
        var yyy = dictionary["ChecklistIndex"] as Int
        println("Dict Values:")
        println("FirstTime = \(xxx)")
        println("ChecklistIndex = \(yyy)")
        
/*        let x = NSUserDefaults.standardUserDefaults().boolForKey("FirstTime")
        let y = NSUserDefaults.standardUserDefaults().integerForKey("ChecklistIndex")
        println("Before:")
        println("FirstTime = \(x)")
        println("ChecklistIndex = \(y)")
*/        
        let d1 = ["ChecklistIndex": -1]
        NSUserDefaults.standardUserDefaults().registerDefaults(dictionary as NSDictionary)
        
        let xx = NSUserDefaults.standardUserDefaults().boolForKey("FirstTime")
        let yy = NSUserDefaults.standardUserDefaults().integerForKey("ChecklistIndex")
        println("After:")
        println("FirstTime = \(xx)")
        println("ChecklistIndex = \(yy)")
        
    }
    
    func handleFirstTime()  {
        let firstTime = NSUserDefaults.standardUserDefaults().boolForKey("FirstTime")
        println("firstTime is \(firstTime)!")
        if firstTime    {
            var checklist = Checklist(name: "List")
            lists.append(checklist)
            setIndexOfSelectedChecklist(0)
            NSUserDefaults.standardUserDefaults().setBool(false, forKey: "FirstTime")
        }
    }
    
    init() {
        loadChecklists()
        registerDefaults()
        handleFirstTime()
    }
    
    // Helper functions from tutorial
    
    func documentsDirectory() -> String   {
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        return paths[0] as String
    }
    
    func dataFilePath() -> String {
        return documentsDirectory().stringByAppendingPathComponent("Checklists.plist")
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
//        println(path)
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
        
        let x = NSUserDefaults.standardUserDefaults().integerForKey("ChecklistIndex")
        println("setIndexOfSelectedChecklist: \(x)")
        
    }
    
    func sortChecklists() {
        lists.sort {$0.name < $1.name}
    }
}
