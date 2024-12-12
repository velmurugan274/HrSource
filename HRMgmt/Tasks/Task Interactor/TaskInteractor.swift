//
//  TaskInteractor.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 08/06/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
class TaskInteractor : TaskInputInteractorProtocol{
    var presenter: TaskOutputInteractorProtocol?
    
    func getCompleteList(empUuid: String) {
        var completeList : [Task] = []
        completeList = db.getCompletedTask(empUuid : empUuid)
        presenter?.updatedCompleteList(complete: completeList)
    }
    
    func getIncompleteList(empUuid: String) {
        var incompleteList: [Task] = []
        incompleteList = db.getIncompleteTask(empUuid : empUuid)
        presenter?.updatedIncompleteList(incomplete: incompleteList)
    }
    
    
}
