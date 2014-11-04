//
//  Checklist.swift
//  Checklists
//
//  Created by James Scott on 7/13/14.
//  Copyright (c) 2014 jscott10. All rights reserved.
//

import Foundation

class Checklist: NSObject, NSCoding {
    
    var name = ""
    var items = [ChecklistItem]()
    var iconName = ""
    
    // "name" is required because a Checklist will always have a title
    init(name: String)  {
        self.name = name
    }

    // Part of the NSCoding protocol
    required init(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObjectForKey("Name") as String
        items = aDecoder.decodeObjectForKey("Items") as [ChecklistItem]
        iconName = aDecoder.decodeObjectForKey("iconName") as String
        super.init()
    }
    
    // Part of the NSCoding protocol
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: "Name")
        aCoder.encodeObject(items, forKey: "Items")
        aCoder.encodeObject(iconName, forKey: "iconName")
    }
    
    func countUncheckedItems() -> Int   {
        var count = 0
        for item in items   {
            if !item.checked    {
                count += 1
            }
        }
        return count
    }
    
}
