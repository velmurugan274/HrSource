//
//  CreateTaskInteractor.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 12/06/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
class CreateTaskInteractor : CreateTaskInputInteractorProtocol {
    func updateTask(task: Task) {
        db.createTask(task: task)
    }
    
    var presenter: CreateTaskOutputInteractorProtocol?
    
    func getTaskOwner(empUuid: String) {
        let taskOwners =  db.getTaskOwners(empUuid: empUuid)
        presenter?.setTaskOwners(taskOwners: taskOwners)
    }
    
    
}
