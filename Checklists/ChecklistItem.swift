//
//  ChecklistItem.swift
//  Checklists
//
//  Created by James Scott on 7/1/14.
//  Copyright (c) 2014 jscott10. All rights reserved.
//

import Foundation

// App crashes if ChecklistItem is not made a subclass of NSObject!!!

/*
From stackoverflow:
NSKeyedArchiver will only work with Objective-C classes, not pure Swift classes. You can bridge your class to Obj-C by marking it with the @objc attribute or by inheriting from an Objective-C class, such as NSObject.

NOTE: @objc doesn't seem to fix it!

*/

class ChecklistItem : NSObject, NSCoding {
//@objc class ChecklistItem : NSCoding {
    
    var text: String
    var checked: Bool
    
    init(text: String, checked: Bool)   {
        self.text = text
        self.checked = checked
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        var text = aDecoder.decodeObjectForKey("Text") as String
        var checked = aDecoder.decodeBoolForKey("Checked") as Bool
        self.init(text: text, checked: checked)
    }
    
    func toggleChecked()  {
        checked = !checked
    }
    
    func encodeWithCoder(aCoder: NSCoder)  {
        aCoder.encodeObject(text, forKey: "Text")
        aCoder.encodeBool(checked, forKey: "Checked")
    }
}

