//
//  WindowDelegate.swift
//  Intervals
//
//  Created by Christopher on 14-12-2020.
//

import AppKit

class WindowDelegate: NSObject, NSWindowDelegate {

    func windowWillClose(_ notification: Notification) {
        NSApplication.shared.terminate(0)
    }
}
