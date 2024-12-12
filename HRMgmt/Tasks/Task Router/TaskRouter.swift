//
//  TaskRouter.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 08/06/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
import UIKit
class TaskRouter : TaskRouterProtocol{
    func showTask(from view: UIViewController, with task: Task, with buttonHidden : Bool) {
        let tasks = SingleTaskView()
        tasks.task = task
        tasks.submitButton.isHidden = buttonHidden
        view.navigationController?.pushViewController(tasks, animated: true)
    }
    
    func presentCreateTask(from view: UIViewController, with empUuid: String) {
        let createTask = CreateTask()
        createTask.empUuid = empUuid
        let task = UINavigationController(rootViewController: createTask)
        view.navigationController?.present(task, animated: true, completion: nil)
    }
    
    
    static func createTaskModule(taskRef : TaskView) {
        let presenter : TaskOutputInteractorProtocol & TaskPresenterProtocol = TaskPresenter()
        
        taskRef.presenter = presenter
        taskRef.presenter?.interactor = TaskInteractor()
        taskRef.presenter?.view = taskRef
        taskRef.presenter?.router = TaskRouter()
        taskRef.presenter?.interactor?.presenter = presenter
        
        print("check")
    }

}
