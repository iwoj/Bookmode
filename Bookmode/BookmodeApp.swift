//
//  BookmodeApp.swift
//  Bookmode
//
//  Main application entry point
//

import SwiftUI
import UserNotifications

@main
struct BookmodeApp: App {
    @StateObject private var bookManager = BookManager()
    @StateObject private var activityMonitor = ActivityMonitorService()
    @StateObject private var notificationService = NotificationService()
    
    init() {
        // Request notification permissions on app launch
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Notification permission granted")
            } else if let error = error {
                print("Notification permission error: \(error.localizedDescription)")
            }
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(bookManager)
                .environmentObject(activityMonitor)
                .environmentObject(notificationService)
                .onAppear {
                    // Start monitoring when app appears
                    activityMonitor.startMonitoring(
                        bookManager: bookManager,
                        notificationService: notificationService
                    )
                }
        }
    }
}
