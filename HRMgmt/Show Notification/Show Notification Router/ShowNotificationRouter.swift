//
//  ShowNotificationRouter.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 25/06/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
class ShowNotificationRouter : ShowNotificationRouterProtocol{
    static func createShowNotificationModule(showNotificationRef: ShowNotification) {
        let presenter : ShowNotificationOutputInteractorProtocol & ShowNotificationPresenterProtocol = ShowNotificationPresenter()
        
        showNotificationRef.presenter = presenter
        showNotificationRef.presenter?.interactor = ShowNotificationInteractor()
        showNotificationRef.presenter?.view =  showNotificationRef
        showNotificationRef.presenter?.router = ShowNotificationRouter()
        showNotificationRef.presenter?.interactor?.presenter = presenter

    }
    
    
    
}
