//
//  SingleViewPeresenter.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 17/06/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
class SingleTaskPresenter : SingleTaskPresenterProtocol{
    var interactor: SingleTaskInputInteractorProtocol?
    
    var view: SingleTaskViewProtocol?
    
    var router: SingleTaskRouterProtocol?
    
    func markAsCompleted(taskId: String) {
        interactor?.markAsCompleted(taskId: taskId)
    }
    
    func getReporterName(empUuid: String) {
        interactor?.getReporterName(empUuid: empUuid)
    }
    
    
}
extension SingleTaskPresenter : SingleTaskOutputInteractorProtocol{
    
    
    func setReporterName(name: String) {
        view?.setReporterName(name: name)
    }
    
    
}
