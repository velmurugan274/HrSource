//
//  ApplyLeavePresenter.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 30/05/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
import UIKit
class ApplyLeavePresenter : ApplyLeavePresenterProtocol {
    func getDeptId(empUuid: String) {
        interactor?.getDeptId(empUuid: empUuid)
    }
    
    var interactor: ApplyLeaveInputInteractorProtocol?
    
    var view: ApplyLeaveViewProtocol?
    
    var router: ApplyLeaveRouterProtocol?
    
    func updateLeave(leave: Leave) {
        interactor?.updateLeave(leave: leave)
    }
    
    func presentHomeTab(from view : UIViewController, with empUuid : String) {
        print("yes2")
        router?.presentHomeTab(from : view, with: empUuid)
    }
    
    
}
extension ApplyLeavePresenter : ApplyLeaveOutputInteractorProtocol{
   
    func setDeptId(deptId: String) {
        view?.setDeptId(deptId: deptId)
        
    }
    
    
}
