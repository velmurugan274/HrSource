//
//  HomeInteractor.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 29/05/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
class HomeInteractor : HomeInputInteractorProtocol {
    func checkNotification(empUuid: String) {
        let check = db.checkNotifDetails(empUuid: empUuid)
        presenter?.updatedNotifStatus(notifCheck: check)
    }
    
    func getCurrentStatus(empUuid: String) {
        let status = fetchCurrentStatus(empUuid:empUuid)
        presenter?.currentStatus(status: status)
    }
    
    func fetchCurrentStatus(empUuid : String) -> String{
        let date = Date()
        var x = Int(date.timeIntervalSince1970)
        x = x - (x%86400) - 19800
        let status = db.getCurrentStatus(empUuid: empUuid, date: x)
        if status.rawValue == "CHECK IN"{
        return "CHECK IN"
        }
        else{
        return "CHECK OUT"
        }
    }
    
    
    var presenter: HomeOutputInteractorProtocol?
    
    func getActiveHours(empUuid: String) {
        var activeHours : String?
        let date = Date()
        var x = Int(date.timeIntervalSince1970)
        x = x - (x%86400) - 19800
        let secCount = db.getSecondsCount(date : x, empUuid : empUuid)
        
        if(secCount>0){
            activeHours = ( String(format: "%02d", secCount/3600)+":"+String(format: "%02d", (secCount%3600)/60))
        }else{
            activeHours =  "00:00"
        }
        presenter?.updatedActiveHours(activeHours: activeHours!)
    }
    
    func updateStatus(empUuid: String) {
        db.changeCurrentStatus(empUuid: empUuid)
    }
    
}
