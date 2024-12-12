//
//  ApplyLeaveInteractor.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 30/05/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
class ApplyLeaveInteractor : ApplyLeaveInputInteractorProtocol {
    func getDeptId(empUuid: String) {
        let x = db.getDeptUuid(empUuid: empUuid)
        presenter?.setDeptId(deptId: x)
    }
    
    var presenter: ApplyLeaveOutputInteractorProtocol?
    
    func updateLeave(leave: Leave) {
        db.updateLeaveDetails(leave: leave)
        
    }
    
    
}
