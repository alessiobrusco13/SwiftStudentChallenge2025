//
//  NotificationManager.swift
//  SwiftStudentChallenge2025
//
//  Created by Alessio Garzia Marotta Brusco on 24/02/25.
//

import Foundation
import UserNotifications

final class NotificationManager: @unchecked Sendable {
    struct Notification: Hashable {
        enum Kind {
            case appQuitDuringSession
            case stopPauseReminder
            case startPauseReminder
            case general
        }
        
        let id: String
        let kind: Kind
    }
    
    private var scheduledNotification = Set<Notification>()
    private var notificationCenter = UNUserNotificationCenter.current()
    
    func requestAuthorization() async {
        do {
            try await notificationCenter.requestAuthorization(options: [.alert])
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // Controlla che se metto ricorda pausa, non deve eccedere del tempo rimaente
    func scheduleNotification(ofKind kind: Notification.Kind) async {
        let request = createNotification(ofKind: kind)
        let notification = Notification(id: request.identifier, kind: kind)
        
        do {
            try await notificationCenter.add(request)
            scheduledNotification.insert(notification)
        } catch {
            print(error)
        }
    }
    
    func removeScheduledNotification(ofKind kind: Notification.Kind) {
        guard let notification = scheduledNotification.first(where: { $0.kind == kind }) else {
            return
        }
        
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [notification.id])
    }
    
    private func createNotification(ofKind kind: Notification.Kind) -> UNNotificationRequest {
        let content = UNMutableNotificationContent()
        let trigger: UNNotificationTrigger
        
        switch kind {
        case .appQuitDuringSession:
            content.title = "Session Interrupted"
            content.body = "Hey, come back and continue studying!"
            trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
            
        case .stopPauseReminder:
            content.title = "Break’s Over!"
            content.body = "Time to get back on track. Let’s finish what you started!"
            trigger = UNTimeIntervalNotificationTrigger(timeInterval: 15*60, repeats: false)
            
        case .startPauseReminder:
            content.title = "Take a Breather"
            content.body = "A short break can boost focus. Step away, then come back strong!"
            trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60*60, repeats: false)
            
        case .general:
            content.title = "Stay on Track"
            content.body = "Small steps lead to big progress. What’s your next move?"
            
            var dateComponents = DateComponents()
            dateComponents.calendar = Calendar.current
            dateComponents.hour = 14
            
            trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        }
        
        return UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
    }
}
