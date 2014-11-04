//
//  ChecklistItem.swift
//  Checklists
//
//  Created by James Scott on 7/1/14.
//  Copyright (c) 2014 jscott10. All rights reserved.
//

import Foundation

class ChecklistItem : NSObject, NSCoding {
    
    var text = ""
    var checked = false
    
    override init()  {
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        text = aDecoder.decodeObjectForKey("Text") as String
        checked = aDecoder.decodeBoolForKey("Checked")
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder)  {
        aCoder.encodeObject(text, forKey: "Text")
        aCoder.encodeBool(checked, forKey: "Checked")
    }
    
    func toggleChecked()  {
        checked = !checked
    }
    
}

