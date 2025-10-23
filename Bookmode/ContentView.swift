//
//  ContentView.swift
//  Bookmode
//
//  Main content view with tab navigation
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var bookManager: BookManager
    @EnvironmentObject var activityMonitor: ActivityMonitorService
    
    var body: some View {
        TabView {
            BooksView()
                .tabItem {
                    Label("Books", systemImage: "book.fill")
                }
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(BookManager())
        .environmentObject(ActivityMonitorService())
        .environmentObject(NotificationService())
}
