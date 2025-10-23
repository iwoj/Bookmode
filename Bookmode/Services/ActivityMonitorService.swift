//
//  ActivityMonitorService.swift
//  Bookmode
//
//  Monitors device activity using Screen Time APIs and Device Activity Monitor
//

import Foundation
import FamilyControls
import DeviceActivity
import ManagedSettings

class ActivityMonitorService: ObservableObject {
    @Published var isMonitoring = false
    @Published var authorizationStatus: AuthorizationStatus = .notDetermined
    
    private let deviceActivityCenter = DeviceActivityCenter()
    private let activityName = DeviceActivityName("socialMediaMonitoring")
    
    // Social media app tokens - these would need to be selected by the user via FamilyActivityPicker
    @Published var selectedApps: Set<ApplicationToken> = []
    
    private var bookManager: BookManager?
    private var notificationService: NotificationService?
    
    // Doom scrolling detection threshold (in seconds)
    private let doomScrollingThreshold: TimeInterval = 300 // 5 minutes
    
    init() {
        checkAuthorizationStatus()
    }
    
    func requestAuthorization() async {
        do {
            try await AuthorizationCenter.shared.requestAuthorization(for: .individual)
            await MainActor.run {
                checkAuthorizationStatus()
            }
        } catch {
            print("Failed to request authorization: \(error)")
        }
    }
    
    func checkAuthorizationStatus() {
        authorizationStatus = AuthorizationCenter.shared.authorizationStatus
    }
    
    func startMonitoring(bookManager: BookManager, notificationService: NotificationService) {
        self.bookManager = bookManager
        self.notificationService = notificationService
        
        guard authorizationStatus == .approved else {
            print("Screen Time authorization not granted")
            return
        }
        
        // Set up monitoring schedule
        let schedule = DeviceActivitySchedule(
            intervalStart: DateComponents(hour: 0, minute: 0),
            intervalEnd: DateComponents(hour: 23, minute: 59),
            repeats: true
        )
        
        // Create event for doom scrolling detection
        let event = DeviceActivityEvent(
            applications: selectedApps,
            threshold: DateComponents(second: Int(doomScrollingThreshold))
        )
        
        let events: [DeviceActivityEvent.Name: DeviceActivityEvent] = [
            DeviceActivityEvent.Name("doomScrollingDetected"): event
        ]
        
        do {
            try deviceActivityCenter.startMonitoring(activityName, during: schedule, events: events)
            isMonitoring = true
            print("Started monitoring device activity")
        } catch {
            print("Failed to start monitoring: \(error)")
        }
    }
    
    func stopMonitoring() {
        deviceActivityCenter.stopMonitoring([activityName])
        isMonitoring = false
        print("Stopped monitoring device activity")
    }
    
    // This method is called by the DeviceActivityMonitor extension when threshold is reached
    func handleDoomScrollingDetected() {
        guard let bookManager = bookManager,
              let notificationService = notificationService,
              let book = bookManager.getRandomBook() else {
            return
        }
        
        // Generate and send notification about the book
        Task {
            await notificationService.sendBookNotification(for: book)
        }
    }
    
    // Manual trigger for testing
    func simulateDoomScrolling() {
        handleDoomScrollingDetected()
    }
}

extension DeviceActivityEvent.Name {
    static let doomScrollingDetected = Self("doomScrollingDetected")
}
