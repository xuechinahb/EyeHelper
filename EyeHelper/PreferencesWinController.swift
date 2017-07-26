//
//  PreferencesWinController.swift
//  EyeHelper
//
//  Created by evan on 5/12/17.
//  Copyright © 2017 evan. All rights reserved.
//

import Cocoa
import ServiceManagement

class PreferencesWinController: NSWindowController, NSWindowDelegate, NSTextFieldDelegate {

    
    @IBOutlet weak var intervalTextField: NSTextField!
    
    @IBOutlet weak var stepper: NSStepper!
    
    @IBOutlet weak var pwdTextField: NSTextField!
    
    @IBOutlet weak var launchAtLoginButton: NSButton!
    fileprivate let bundleIdentifier = "com.evan.EyeHelper.LaunchHelper"
    
    var userDefaults: UserDefaults! = nil
    override func windowDidLoad() {
        super.windowDidLoad()

       
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
        
       self.window?.title = "Preference"
        self.intervalTextField.formatter = OnlyNumbericFormatter()
        userDefaults = UserDefaults.standard
        self.intervalTextField.integerValue = userDefaults.integer(forKey: AppDelegate.TIME_INTERVAL)
        stepper.integerValue = intervalTextField.integerValue
        pwdTextField.stringValue = userDefaults.string(forKey: AppDelegate.PASSWORD)!
        launchAtLoginButton.state = userDefaults.integer(forKey: AppDelegate.LAUNCH_AT_LOGIN)
    }
    
    
    
    @IBAction func stepperAction(_ sender: NSStepper) {
        intervalTextField.integerValue = sender.integerValue
    }
    
    
    func windowWillClose(_ notification: Notification) {
        
        let intervalValue = intervalTextField.integerValue
        if intervalValue != userDefaults.integer(forKey: AppDelegate.TIME_INTERVAL) {
            userDefaults.set(intervalValue, forKey: AppDelegate.TIME_INTERVAL)
            let appDelegate = NSApplication.shared().delegate as! AppDelegate
            appDelegate.lockFlag = false
            appDelegate.resetTimer()
        }
        
        userDefaults.set(pwdTextField.stringValue, forKey: AppDelegate.PASSWORD)
        
    }
    
   
    
    override func controlTextDidChange(_ obj: Notification) {
        if let textObj = obj.object as? NSTextField{
            if textObj === intervalTextField{
                stepper.integerValue = intervalTextField.integerValue
            }
        }
            
        
    }
    
    @IBAction func launchAtLoginAction(_ sender: NSButton) {

        userDefaults.set(sender.state, forKey: AppDelegate.LAUNCH_AT_LOGIN)
        do {
            try launchAtlogin(enabled: sender.state == NSOnState)
        } catch let error as NSError {
            NSAlert(error: error).runModal()
        }
    
        
    }
    
    
    func launchAtlogin(enabled: Bool) throws {
        guard !SMLoginItemSetEnabled(self.bundleIdentifier as CFString, enabled) else { return }
        let appName = Bundle.main.infoDictionary!["CFBundleName"]!
        let message = enabled ? "Failed to add \(appName) to your login items." : "Failed to remove \(appName) from your login items."
        throw NSError(domain: self.bundleIdentifier, code: 1, userInfo: [NSLocalizedDescriptionKey: message])
    }

    
    
}
