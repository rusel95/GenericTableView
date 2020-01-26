//
//  NotificationsHandler.swift
//  MVVM_RxSwift_Example
//
//  Created by Ruslan Popesku on 12/7/18.
//  Copyright © 2019 Ruslan Popesku. All rights reserved.
//

import Foundation
import UserNotifications
import RxSwift
import RxCocoa

public final class NotificationsService: NSObject {
    
    public static let shared = NotificationsService()
    
    enum LocalNotificationType: String {
        case workIntervalFinished
        case shortBreakIntervalFinished
        case longBreakIntervalFinished
        case dailyGoalDone
    }
    
    private override init() {
        super.init()
    }
    
    private let center = UNUserNotificationCenter.current()
    
    // MARK: Local notifications
    
    func scheduleLocalNotification(_ type: LocalNotificationType, in delay: UInt16) {
        removeLocalNotifications(of: type)
        
        let title = "test"
        let body = "body"
        let date = Date().addingTimeInterval(TimeInterval(delay))
        let sound = UNNotificationSound.default
        
        scheduleLocalNotification(identifier: type.rawValue, title: title, body: body, sound: sound, date: date)
    }
    
    func removeLocalNotifications(of type: LocalNotificationType) {
        center.removePendingNotificationRequests(withIdentifiers: [type.rawValue])
    }
    
    func removeAllNotifications() {
        DispatchQueue.main.async {
            self.center.removeAllPendingNotificationRequests()
        }
    }
    
    public func willEnterForeground(application: UIApplication) {
        application.applicationIconBadgeNumber = 0
    }

    public func didFinishLaunching(application: UIApplication, launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        willEnterForeground(application: application)
        
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.delegate = self
            center.requestAuthorization(options: [.badge, .alert, .sound]) { _, _ in }
        } else {
            let notificationSettings = UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil)
            application.registerUserNotificationSettings(notificationSettings)
        }
    }
    
    private func scheduleLocalNotification(
        identifier: String,
        title: String,
        body: String,
        userInfo: [AnyHashable: Any]? = nil,
        sound: UNNotificationSound?,
        date: Date
        ) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = sound
        
        if let info = userInfo {
            content.userInfo = info
        }
        
        let comp = Calendar.current.dateComponents([.hour, .minute, .second], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: comp, repeats: false)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        center.add(request)
    }
    
}

extension NotificationsService: UNUserNotificationCenterDelegate {
    
}
