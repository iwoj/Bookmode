//
//  NotificationService.swift
//  Bookmode
//
//  Handles local notifications
//

import Foundation
import UserNotifications

class NotificationService: ObservableObject {
    private let aiService = AIService()
    
    func sendBookNotification(for book: Book) async {
        // Generate AI content for the notification
        let notificationContent = await aiService.generateBookPrompt(for: book)
        
        // Create notification
        let content = UNMutableNotificationContent()
        content.title = "Time for a Reading Break!"
        content.body = notificationContent
        content.sound = .default
        content.categoryIdentifier = "BOOK_REMINDER"
        
        // Add book info to user info for handling tap
        content.userInfo = [
            "bookId": book.id.uuidString,
            "bookTitle": book.title
        ]
        
        // Trigger immediately
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )
        
        do {
            try await UNUserNotificationCenter.current().add(request)
            print("Notification scheduled for book: \(book.title)")
        } catch {
            print("Failed to schedule notification: \(error)")
        }
    }
    
    func sendTestNotification() async {
        let content = UNMutableNotificationContent()
        content.title = "Test Notification"
        content.body = "This is a test notification from Bookmode!"
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )
        
        do {
            try await UNUserNotificationCenter.current().add(request)
            print("Test notification scheduled")
        } catch {
            print("Failed to schedule test notification: \(error)")
        }
    }
}
