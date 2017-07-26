//
//  AppDelegate.swift
//  LaunchHelper
//
//  Created by evan on 6/12/17.
//  Copyright © 2017 evan. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {



    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
//        guard NSWorkspace.shared().runningApplications.filter({ $0.bundleIdentifier == "com.evan.EyeHelper" }).count == 0 else {  NSApp.terminate(nil); return } // ensure the main app isn't running
        
        let bundlePathComponents = (Bundle.main.bundlePath as NSString).pathComponents
        var pathComponents = Array(bundlePathComponents[0...(bundlePathComponents.count-4)])
//        pathComponents.append(contentsOf: [ "MacOS", "EyeHelper" ])
        let path = NSString.path(withComponents: pathComponents)
//        do {
//            try NSWorkspace.shared().launchApplication(at: URL(fileURLWithPath: path), options: .default, configuration: [ NSWorkspaceLaunchConfigurationArguments: "helper" ])
//        } catch let error as NSError {
//            NSLog("%@", error)
//        }
        
        NSWorkspace.shared().launchApplication(path)
        
        NSApp.terminate(nil)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

