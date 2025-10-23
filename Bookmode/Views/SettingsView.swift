//
//  SettingsView.swift
//  Bookmode
//
//  Settings and configuration view
//

import SwiftUI
import FamilyControls

struct SettingsView: View {
    @EnvironmentObject var activityMonitor: ActivityMonitorService
    @EnvironmentObject var notificationService: NotificationService
    @State private var apiKey: String = ""
    @State private var showingAppPicker = false
    @State private var showingAPIKeyAlert = false
    
    private let aiService = AIService()
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Screen Time Monitoring")) {
                    HStack {
                        Text("Authorization Status")
                        Spacer()
                        Text(authStatusText)
                            .foregroundColor(authStatusColor)
                            .font(.caption)
                    }
                    
                    if activityMonitor.authorizationStatus != .approved {
                        Button("Request Authorization") {
                            Task {
                                await activityMonitor.requestAuthorization()
                            }
                        }
                    }
                    
                    if activityMonitor.authorizationStatus == .approved {
                        Button("Select Social Media Apps") {
                            showingAppPicker = true
                        }
                        
                        HStack {
                            Text("Monitoring Active")
                            Spacer()
                            Toggle("", isOn: .constant(activityMonitor.isMonitoring))
                                .disabled(true)
                        }
                        
                        Text("Selected Apps: \(activityMonitor.selectedApps.count)")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                
                Section(header: Text("AI Configuration")) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("OpenAI API Key")
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                        SecureField("Enter API Key", text: $apiKey)
                            .textContentType(.password)
                        
                        Button("Save API Key") {
                            aiService.updateAPIKey(apiKey)
                            showingAPIKeyAlert = true
                        }
                        .disabled(apiKey.isEmpty)
                        
                        Text("API key is stored securely and used to generate personalized book notifications.")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .padding(.top, 4)
                    }
                }
                
                Section(header: Text("Notifications")) {
                    Button("Send Test Notification") {
                        Task {
                            await notificationService.sendTestNotification()
                        }
                    }
                    
                    Text("Make sure notifications are enabled in Settings app")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                Section(header: Text("Testing")) {
                    Button("Simulate Doom Scrolling") {
                        activityMonitor.simulateDoomScrolling()
                    }
                    .disabled(activityMonitor.authorizationStatus != .approved)
                    
                    Text("This will trigger a book notification as if you were doom scrolling")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                Section(header: Text("About")) {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("1.0")
                            .foregroundColor(.gray)
                    }
                    
                    HStack {
                        Text("Doom Scrolling Threshold")
                        Spacer()
                        Text("5 minutes")
                            .foregroundColor(.gray)
                    }
                }
            }
            .navigationTitle("Settings")
            .onAppear {
                apiKey = aiService.getAPIKey()
            }
            .familyActivityPicker(
                isPresented: $showingAppPicker,
                selection: $activityMonitor.selectedApps
            )
            .alert("API Key Saved", isPresented: $showingAPIKeyAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("Your OpenAI API key has been saved securely.")
            }
        }
    }
    
    private var authStatusText: String {
        switch activityMonitor.authorizationStatus {
        case .notDetermined:
            return "Not Requested"
        case .denied:
            return "Denied"
        case .approved:
            return "Approved"
        @unknown default:
            return "Unknown"
        }
    }
    
    private var authStatusColor: Color {
        switch activityMonitor.authorizationStatus {
        case .approved:
            return .green
        case .denied:
            return .red
        default:
            return .orange
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(ActivityMonitorService())
        .environmentObject(NotificationService())
}
