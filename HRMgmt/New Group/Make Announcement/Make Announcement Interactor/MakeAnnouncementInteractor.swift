//
//  MakeAnnouncementInteractor.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 11/06/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
class MakeAnnouncementInteractor : MakeAnnouncementInputInteractorProtocol{
    func updateAnnoucement(announcement: MakeAnnouncement, empUuid :String) {
        db.setNotification(makeAnnouncement: announcement, empUuid: empUuid)
    }
    
    var presenter: MakeAnnouncementOutputInteractorProtocol?
    
    
    
    func getDeptId(empUuid: String) {
        let deptUuid  = db.getDeptUuid(empUuid: empUuid)
        presenter?.setDeptId(deptId: deptUuid)
    }
    
    func getAllDept() {
        let deptUuid = db.getAllDeptUuid()
        presenter?.setAllDept(deptId: deptUuid)
    }
    
    
}


