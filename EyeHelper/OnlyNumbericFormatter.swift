//
//  OnlyNumbericFormatter.swift
//  EyeHelper
//
//  Created by evan on 6/6/17.
//  Copyright © 2017 evan. All rights reserved.
//

import Cocoa

class OnlyNumbericFormatter: NumberFormatter {
    override func isPartialStringValid(_ partialString: String, newEditingString newString: AutoreleasingUnsafeMutablePointer<NSString?>?, errorDescription error: AutoreleasingUnsafeMutablePointer<NSString?>?) -> Bool {
        if (partialString as NSString).length == 0 {
            return true
        }
        
        if (partialString as NSString).length > 3 {
            return false
        }
        
        
        let scanner = Scanner(string: partialString)
        var zeroNum = 0
        if !(scanner.scanInt(&zeroNum) && scanner.isAtEnd) {
            NSBeep()
            return false
        }
        return true
    }

}
