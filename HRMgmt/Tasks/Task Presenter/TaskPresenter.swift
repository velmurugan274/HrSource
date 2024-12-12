//
//  TaskPresenter.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 08/06/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
import UIKit
class TaskPresenter : TaskPresenterProtocol {
    func showTask(from view: UIViewController, with task: Task, with buttonHidden: Bool) {
        router?.showTask(from: view, with: task, with: buttonHidden)
    }
    
   
    
    func presentCreateTask(from view: UIViewController, with empUuid: String) {
        router?.presentCreateTask(from: view, with: empUuid)
    }
    
    var interactor: TaskInputInteractorProtocol?
    
    var view: TaskViewProtocol?
    
    var router: TaskRouterProtocol?
    
    func getCompleteList(empUuid: String) {
        interactor?.getCompleteList(empUuid: empUuid)
    }
    
    func getIncompleteList(empUuid: String) {
        interactor?.getIncompleteList(empUuid: empUuid)
    }
    
    
}
extension TaskPresenter : TaskOutputInteractorProtocol{
    func updatedIncompleteList(incomplete: [Task]) {
        view?.updatedIncompleteList(incomplete: incomplete)
        print("check2")
    }
    
    func updatedCompleteList(complete: [Task]) {
        view?.updatedCompleteList(complete: complete)
        print("check3")
    }
    
    
}
