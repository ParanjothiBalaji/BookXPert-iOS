//
//  NotificationManager.swift
//  BookXPert-Assignment
//
//  Created by Paranjothi Balaji on 20/06/25.
//

import UserNotifications
import UIKit

final class NotificationManager {
    
    static let shared = NotificationManager()
    private let kNotificationToggleKey = "isNotificationsEnabled"
    
    private init() {}
    
    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        let center = UNUserNotificationCenter.current()
        
        center.getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .notDetermined:
                center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
                    DispatchQueue.main.async {
                        completion(granted)
                    }
                }
            case .denied:
                DispatchQueue.main.async {
                    self.showSettingsAlert()
                    completion(false)
                }
            case .authorized, .provisional, .ephemeral:
                DispatchQueue.main.async {
                    completion(true)
                }
            @unknown default:
                DispatchQueue.main.async {
                    completion(false)
                }
            }
        }
    }
    
    func showSettingsAlert() {
        DispatchQueue.main.async {
            guard let window = UIApplication.shared.connectedScenes
                .compactMap({ $0 as? UIWindowScene })
                .first?.windows.first(where: { $0.isKeyWindow }),
                  let rootVC = window.rootViewController else { return }
            
            let alert = UIAlertController(
                title: "Notification Permission Denied",
                message: "To receive notifications, enable them in Settings.",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            alert.addAction(UIAlertAction(title: "Open Settings", style: .default, handler: { _ in
                if let settingsURL = URL(string: UIApplication.openSettingsURLString),
                   UIApplication.shared.canOpenURL(settingsURL) {
                    UIApplication.shared.open(settingsURL)
                }
            }))
            rootVC.present(alert, animated: true)
        }
    }
    
    func isNotificationsEnabled() -> Bool {
        return UserDefaults.standard.bool(forKey: kNotificationToggleKey)
    }
    
    func setNotificationsEnabled(_ enabled: Bool) {
        UserDefaults.standard.set(enabled, forKey: kNotificationToggleKey)
    }
    
    func sendDeleteNotification(name: String, id: String) {
        guard isNotificationsEnabled() else {
            print("Notification not sent because toggle is OFF.")
            return
        }
        
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            guard settings.authorizationStatus == .authorized else {
                print("Notification permission not granted.")
                return
            }
            
            let content = UNMutableNotificationContent()
            content.title = "Item Deleted"
            content.body = "You deleted: \(name) (ID: \(id))"
            content.sound = .default
            
            let request = UNNotificationRequest(
                identifier: UUID().uuidString,
                content: content,
                trigger: nil
            )
            
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("Failed to schedule notification: \(error.localizedDescription)")
                } else {
                    print("Notification scheduled.")
                }
            }
        }
    }
    
}
