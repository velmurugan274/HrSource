//
//  PermissionInteractor.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 16/06/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
class PermissionInteractor : PermissionInputInteractorProtocol {
    var presenter: PermissionOutputInteractorProtocol?
    
    func updatePermission(permission: Permission) {
        db.updatePermission(permission: permission)
    }
    
    func getReporterId(empUuid: String) {
        let reporterId = db.getReporterUuid(empUuid: empUuid)
        presenter?.setReporterId(empUuid: reporterId)
    }
    
    
}
