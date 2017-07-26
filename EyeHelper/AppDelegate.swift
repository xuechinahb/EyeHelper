//
//  AppDelegate.swift
//  EyeHelper
//
//  Created by evan on 5/11/17.
//  Copyright © 2017 evan. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    public static let TIME_INTERVAL: String = "TIME_INTERVAL"
    public static let PASSWORD: String = "PASSWORD"
    public static let LAUNCH_AT_LOGIN: String = "LAUNCH_AT_LOGIN"
    
    var timer: Timer?
    var lockFlag = false

    
    
    let statusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
    
    var lockWinController: LockWinController!
    var preferencesWinController: PreferencesWinController!


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    
        if let button = statusItem.button {
            button.image = NSImage(named: "StatusBarButtonImage")
            button.action = #selector(statusBarAction)
        }
        initMenu()
        
        self.resetTimer()
        
//       var sourcePath = Bundle.main.path(forResource: "EyeHelper", ofType: "app")
        
    }
    
  
    func initMenu(){
        let menu = NSMenu()
        menu.addItem(NSMenuItem(title: "Locks", action: #selector(lockScreen), keyEquivalent: "L"))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Preferces", action: #selector(openPreference), keyEquivalent: ","))
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(terminate), keyEquivalent: "q"))
        statusItem.menu = menu
    }
    
    
    
    func lockScreen(){
        if let tempTimer = timer {
            tempTimer.invalidate()
        }
        self.lockFlag = true
        
        lockWinController = LockWinController(windowNibName: "LockWinController")
        let screen = NSScreen.main()
        lockWinController.window?.contentMinSize = (screen?.frame.size)!

        var frame = screen?.frame
        frame?.size.height += 20
        lockWinController.window?.contentView?.layer?.backgroundColor = CGColor(red:  0.784, green: 0.929, blue: 0.8, alpha: 1)
        lockWinController.window?.setFrame(frame!, display: true)
        lockWinController.window?.collectionBehavior = NSWindowCollectionBehavior.fullScreenPrimary;
        lockWinController.window?.level = Int(CGShieldingWindowLevel())//屏蔽键盘，dock
        
        
        lockWinController.showWindow(self)
        lockWinController.window?.contentView?.enterFullScreenMode(NSScreen.main()!, withOptions: nil)
        
      }
    
    
    var win: NSWindowController?
    func openPreference(){
        preferencesWinController = PreferencesWinController(windowNibName: "PreferencesWinController")
       
        let screen = NSScreen.main()
        preferencesWinController.window?.setFrameOrigin(NSPoint(x: ((screen?.frame.width)! - (preferencesWinController.window?.frame.width)!) / 2, y: (screen?.frame.height)! * 0.5))
        preferencesWinController.showWindow(self)
        preferencesWinController.window?.orderFrontRegardless()
        
    }
    
    func terminate(){
        
        if  timer?.isValid == true {
            timer?.invalidate()
        }
        
        
        NSApp.terminate(self)
    }
    func statusBarAction(){
        
    }

    
    func resetTimer(){
        if self.lockFlag {
            return
        }
        
        if  timer?.isValid == true {
            timer?.invalidate()
        }
        
        let timeInterval = UserDefaults.standard.integer(forKey: AppDelegate.TIME_INTERVAL)
        if timeInterval <= 0 {
            print("timeInterval <= 0")
            return
        }
        print("timeInterval is \(timeInterval)")
        timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(timeInterval * 60), repeats: false, block: { (timer) in
            if !self.lockFlag {
                self.lockScreen()
            }
        })
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

