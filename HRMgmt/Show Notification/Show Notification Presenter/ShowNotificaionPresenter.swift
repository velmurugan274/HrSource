//
//  ShowNotificaionPresenter.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 25/06/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
class ShowNotificationPresenter : ShowNotificationPresenterProtocol{
    var router: ShowNotificationRouterProtocol?
    
    var interactor: ShowNotificationInputInteractorProtocol?
    
    var view: ShowNotificationViewProtocol?
    
    func isLiked(empUuid: String, notiId: Int) {
        interactor?.isLiked(empUuid: empUuid, notifId: notiId)
    }
    
    func updateStatus(empUuid: String, notifId: Int, likeStatus: Bool) {
        interactor?.updateStatus(empUuid: empUuid, notifId: notifId, likeStatus: likeStatus)
    }
    
    
}
extension ShowNotificationPresenter : ShowNotificationOutputInteractorProtocol{
    func likeStatus(liked: Bool) {
        view?.likeStatus(liked: liked)
    }
    
}
