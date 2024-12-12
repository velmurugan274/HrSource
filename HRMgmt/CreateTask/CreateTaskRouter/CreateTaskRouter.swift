//
//  CreateTaskRouter.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 12/06/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
import UIKit
class CreateTaskRouter : CreateTaskRouterProtocol {
    func presentHomeTab(from view: UIViewController, with empUuid: String) {
        view.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    static func createCreateTaskModule(createTaskRef: CreateTask) {
        let presenter : CreateTaskOutputInteractorProtocol & CreateTaskPresenterProtocol = CreateTaskPresenter()
        createTaskRef.presenter = presenter
        createTaskRef.presenter?.interactor = CreateTaskInteractor()
        createTaskRef.presenter?.view = createTaskRef
        createTaskRef.presenter?.router = CreateTaskRouter()
        createTaskRef.presenter?.interactor?.presenter = presenter

    }
    
    
}
