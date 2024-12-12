//
//  MakeAnnouncmentPresenter.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 11/06/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
import UIKit
class MakeAnnouncementPresenter : MakeAnnouncementPresenterProtocol{
    func updateAnnoucement(announcement: MakeAnnouncement, empUuid : String) {
        interactor?.updateAnnoucement(announcement: announcement, empUuid : empUuid)
    }
    
    var interactor: MakeAnnouncementInputInteractorProtocol?
    
    var view: MakeAnnouncementViewProtocol?
    
    var router: MakeAnnouncementRouterProtocol?
    
   
    
    func getDeptId(empUuid: String) {
        interactor?.getDeptId(empUuid: empUuid)
    }
    
    func getAllDept() {
        interactor?.getAllDept()
    }
    
    func presentHomeTab(from view: UIViewController, with empUuid: String) {
        router?.presentHomeTab(from: view, with: empUuid)
    }
    
    
}
extension MakeAnnouncementPresenter : MakeAnnouncementOutputInteractorProtocol {
    func setDeptId(deptId: String) {
        view?.setDeptId(deptId: deptId)
    }
    
    func setAllDept(deptId: [String]) {
        view?.setAllDept(allDept: deptId)
    }
    
    
}
