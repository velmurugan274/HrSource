//
//  PermissionPresenter.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 16/06/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
import UIKit
class PermissionPresenter : PermissionPresenterProtocol {
    var interactor: PermissionInputInteractorProtocol?
    
    var view: PermissionViewProtocol?
    
    var router: PermissionRouterProtocol?
    
    func updatePermission(permission: Permission) {
        interactor?.updatePermission(permission: permission)
    }
    
    func getReporterId(empUuid: String) {
        interactor?.getReporterId(empUuid: empUuid)
    }
    
    func presentHomeTab(from view: UIViewController, with empUuid: String) {
        router?.presentHomeTab(from: view, with: empUuid)
    }
    
    
}

extension PermissionPresenter : PermissionOutputInteractorProtocol {
    func setReporterId(empUuid: String) {
        view?.setReporterId(empUuid: empUuid)
    }
    
    
}
