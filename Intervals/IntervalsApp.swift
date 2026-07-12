//
//  IntervalsApp.swift
//  Intervals
//
//  SwiftUI application entry point. Using the SwiftUI App lifecycle ensures
//  the window is displayed on launch and that App Intents can communicate
//  with the running app.
//

import SwiftUI

@main
struct IntervalsApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate

    var body: some Scene {
        WindowGroup {
            DurationView()
                .frame(minWidth: 480, minHeight: 600)
        }
        .windowResizability(.contentSize)
        .defaultSize(width: 480, height: 600)
    }
}
