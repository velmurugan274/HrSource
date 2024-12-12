//
//  ShowNotificationPresenter.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 11/06/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
import UIKit
class NotificationPresenter : NotificationPresenterProtocol {
    func getIndividualNotificationList(empUuid: String) {
        interactor?.getIndividualNotificationList(empUuid: empUuid)
        print("yes")
    }
    
    func showFullNotification(from view: UIViewController, with notification: Notifications, with empUuid: String, with type : Int) {
        router?.showFullNotification(from: view, with: notification, with: empUuid, with: type)
    }
    
    var interactor: NotificationInputInteractorProtocol?
    
    var view: NotificationViewProtocol?
    
    var router: NotificationRouterProtocol?
    
    func getNotificationList(empUuid: String) {
        interactor?.getNotificationList(empUuid: empUuid)
    }
    
    
}
extension NotificationPresenter : NotificationOutputInteractorProtocol{
    func updatedIndividualNotificationList(notification: [Notifications]) {
        view?.updatedNotificationList(notification: notification)
    }
    
    func updatedNotificationList(notification: [Notifications]) {
        view?.updatedNotificationList(notification: notification)
    }
    
    
}
