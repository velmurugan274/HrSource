//
//  SingleTaskInteractor.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 17/06/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
class SingleTaskInteractor : SingleTaskInputInteractorProtocol {
    var presenter: SingleTaskOutputInteractorProtocol?
    
    func markAsCompleted(taskId: String) {
        db.updateTask(taskId : taskId)
    }
    
    func getReporterName(empUuid: String) {
       let name = db.getEmpName(empUuid : empUuid)
        presenter?.setReporterName(name: name)
    }
    
    
}
