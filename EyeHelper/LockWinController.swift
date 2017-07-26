//
//  LockWinController.swift
//  EyeHelper
//
//  Created by evan on 5/12/17.
//  Copyright © 2017 evan. All rights reserved.
//

import Cocoa

class LockWinController: NSWindowController,  NSTextFieldDelegate {

    
    
    @IBOutlet weak var pwdTextField: NSSecureTextField!
    @IBOutlet weak var pwdErrorTextField: NSTextField!
    
    override func windowDidLoad() {
        super.windowDidLoad()
        self.window?.title = "EyeHelper"
    }

    
    
    
    func unlock(){
        let password = UserDefaults.standard.string(forKey: AppDelegate.PASSWORD)
        if password != pwdTextField.stringValue {
            pwdErrorTextField.isHidden = false
            return
        }
        
        self.window?.contentView?.exitFullScreenMode(options: nil)
        self.close()
        
        let appDelegate = NSApplication.shared().delegate as! AppDelegate
        appDelegate.lockFlag = false
        appDelegate.resetTimer()
    }
    
    @IBAction func textFieldAction(_ sender: NSSecureTextField) {
        
        self.window?.close();
    }
    
    override func controlTextDidEndEditing(_ obj: Notification) {
        if let dict = obj.userInfo as? [String: Any]  {
            if (dict["NSTextMovement"] as AnyObject).intValue == NSReturnTextMovement {
               self.unlock()
            }
        }
    }
       
    
}
