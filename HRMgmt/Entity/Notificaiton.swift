//
//  Notification.swift
//  zpeople
//
//  Created by vel-pt2332 on 14/05/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
enum NotifStatus : String{
    case read = "read",
    unread = "unread"
}
class  Notifications {
    private var notificationId : Int
    private var notificationSubject : String
    private var notificationBody : String
    private var notificationSenderId : String
    private var notifLikes : Int
    private var notifStatus : NotifStatus = .unread
    private var notifdate : Int
    
    init(notificationId : Int, notificationSubject: String, notificationBody : String, notificationSenderId:String, notifLikes : Int, notifStatus : NotifStatus, notifdate: Int){
        self.notificationId = notificationId
        self.notificationSubject = notificationSubject
        self.notificationBody = notificationBody
        self.notificationSenderId = notificationSenderId
        self.notifLikes = notifLikes
        self.notifStatus = notifStatus
        self.notifdate = notifdate
    }
    
    func getNotificationId() -> Int{
        return notificationId
    }
    
    func getNotificationSubject() -> String {
        return notificationSubject
    }
    
    func getNotificationBody() -> String {
        return notificationBody
    }
    
    func getNotificationSenderId() -> String {
        return notificationSenderId
    }
    
    func getNotifLikes() -> Int {
        return notifLikes
    }
    
    func getNotifStatus() -> NotifStatus {
        return notifStatus
    }
    
    func getNotifDate() -> Int {
        return notifdate
    }
}
