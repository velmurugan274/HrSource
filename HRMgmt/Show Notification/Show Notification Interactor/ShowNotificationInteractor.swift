//
//  ShowNotificationInteractor.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 25/06/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
class ShowNotificationInteractor : ShowNotificationInputInteractorProtocol {
    
    var presenter: ShowNotificationOutputInteractorProtocol?
    
    
    func isLiked(empUuid: String, notifId: Int) {
        let liked = db.checkLiked(notifId: notifId, empUuid: empUuid)
        presenter?.likeStatus(liked: liked)
    }
    
    func updateStatus(empUuid: String, notifId: Int, likeStatus: Bool) {
        if likeStatus == false{
            db.updateLikes(notifId: notifId, empUUid: empUuid)
        }else{
            db.removeLike(notifId: notifId, empUuid: empUuid)
        }
    }
    
    
    
    
    
    
}
