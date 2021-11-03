//
//  NotificationManager.swift
//  SubscribeTask
//
//  Created by ahmed on 25/10/2021.
//

import Foundation
import UserNotifications

class NotificationManager {
    
    var userDefaultsManager: UserDefaultsManager?
    
    init(userDefaultsManager: UserDefaultsManager) {
        self.userDefaultsManager = userDefaultsManager
    }
    
    public func requestAuthorization(completion: @escaping (Bool) -> ()) {
        let center = UNUserNotificationCenter.current()
    
        center.requestAuthorization(options: [.alert, .sound, .badge]) {
            (granted, error) in
        
            if granted {
                self.scheduleNotification()
                completion(true)
            } else {
                print("Authorization request failed")
                completion(false)
            }
        }
    }
    
    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "SubscribeNotificationTitle".localized
        content.sound = .default
        content.body = "SubscribeNotificationBody".localized
    
        let date = Date().addingTimeInterval(SUBSCRIBE_NOTIFICATION_DELAY)
        let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date), repeats: false)
    
        let request = UNNotificationRequest(identifier: "subscribe", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            self.userDefaultsManager?.removeUser()
        }
    }
}
