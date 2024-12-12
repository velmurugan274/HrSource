//
//  ShowNotificationInteractor.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 11/06/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
class NotificationInteractor : NotificationInputInteractorProtocol{
    func getIndividualNotificationList(empUuid: String) {
        var notification = [Notifications]()
        notification = db.getIndividualNotification(empUuid : empUuid)
        presenter?.updatedIndividualNotificationList(notification: notification)
    }
    
    var presenter: NotificationOutputInteractorProtocol?
    
    func getNotificationList(empUuid: String) {
        var notification = [Notifications]()
        notification = db.getNotification(empUuid : empUuid)
        presenter?.updatedNotificationList(notification: notification)

    }
    
    
}
