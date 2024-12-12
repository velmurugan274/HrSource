//
//  ShowNotificationRouter.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 11/06/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
import UIKit
class NotificationRouter : NotificationRouterProtocol {
    func showFullNotification(from view: UIViewController, with notification: Notifications, with empUuid: String, with type : Int) {
        let notif = ShowNotification()
        notif.notification = notification
        notif.empUuid = empUuid
        if type == 1{
            notif.likeButton.isHidden = true
        }
        view.navigationController?.pushViewController(notif, animated: true)
    }
    
    static func createNotificationModule(notificationRef: NotificationView) {
        let presenter : NotificationOutputInteractorProtocol & NotificationPresenterProtocol = NotificationPresenter()
        
         notificationRef.presenter = presenter
         notificationRef.presenter?.interactor = NotificationInteractor()
         notificationRef.presenter?.view =  notificationRef
         notificationRef.presenter?.router = NotificationRouter()
         notificationRef.presenter?.interactor?.presenter = presenter

    }
    
    
}
