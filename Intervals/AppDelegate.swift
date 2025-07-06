//
//  AppDelegate.swift
//  Intervals
//
//  Created by Christopher on 13-12-2020.
//

import AppKit
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!
    let windowDelegate = WindowDelegate()

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Setup menu
        let appMenu = NSMenuItem()
        appMenu.submenu = NSMenu()
        appMenu.submenu?.addItem(NSMenuItem(title: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
        let mainMenu = NSMenu(title: "Intervals")
        mainMenu.addItem(appMenu)
        NSApplication.shared.mainMenu = mainMenu

        // Create the SwiftUI content view
        let contentView = DurationView()

        // Create the window
        let hostingController = NSHostingController(rootView: contentView)
        window = NSWindow(
            contentViewController: hostingController
        )
        window.setContentSize(NSSize(width: 480, height: 600)) // Increased size
        window.styleMask = [.titled, .closable, .resizable, .miniaturizable]
        window.title = "Intervals"
        window.delegate = windowDelegate
        window.center()
        window.makeKeyAndOrderFront(nil)

        // Activate the app
        NSApp.setActivationPolicy(.regular)
        NSApp.activate(ignoringOtherApps: true)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}
