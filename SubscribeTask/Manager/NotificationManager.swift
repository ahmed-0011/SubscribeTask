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
    
    public func requestAuthorization() {
        let center = UNUserNotificationCenter.current()
    
        center.requestAuthorization(options: [.alert, .sound, .badge]) {
            (granted, error) in
        
            if granted {
                self.scheduleNotification()
            } else {
            print("An error occured")
            }
        }
    }
    
    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Subscribe reminder!"
        content.sound = .default
        content.body = "Reminder to subscribe to the app"
    
        let date = Date().addingTimeInterval(20)
        let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date), repeats: false)
    
        let request = UNNotificationRequest(identifier: "subscribe", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            self.userDefaultsManager?.removeUser()
        }
    }
}
