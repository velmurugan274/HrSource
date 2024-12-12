//
//  CreateTaskPresenter.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 12/06/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
import UIKit
class CreateTaskPresenter : CreateTaskPresenterProtocol {
    func updateTask(task: Task) {
        interactor?.updateTask(task: task)
    }
    
    var interactor: CreateTaskInputInteractorProtocol?
    
    var view: CreateTaskViewProtocol?
    
    var router: CreateTaskRouterProtocol?
    
    func getTaskOwner(empUuid: String) {
        interactor?.getTaskOwner(empUuid: empUuid)
    }
    
    func presentHomeTab(from view: UIViewController, with empUuid: String) {
        router?.presentHomeTab(from: view, with: empUuid)
    }
    
    
}
extension CreateTaskPresenter : CreateTaskOutputInteractorProtocol {
    func setTaskOwners(taskOwners: [TaskOwners]) {
        view?.setTaskOwners(taskOwners: taskOwners)
    }
    
    
}
