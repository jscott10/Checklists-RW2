// Playground - noun: a place where people can play

import UIKit

class ChecklistItem {
    
    var text: String = ""
    var checked: Bool = false
    
    func toggleChecked()  {
        checked = !checked
    }
}

var zz = ChecklistItem()

zz.text = "xxx"
zz.checked = true

zz

zz.toggleChecked()

zz

