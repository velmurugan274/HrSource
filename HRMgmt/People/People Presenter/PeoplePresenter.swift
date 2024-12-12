//
//  PeoplePresenter.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 01/06/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
import UIKit
class PeoplePresenter: PeoplePresenterProtocol {
    func showProfile(from view: UIViewController, with empUuid: String, with selectUuid: String) {
        router?.showProfile(from: view, with: empUuid, with: selectUuid)
    }
    
    func getSearchedList(search: String) {
        interactor?.getSearchedList(search: search)
    }

    var interactor: PeopleInputInteractorProtocol?
    
    var view: PeopleViewProtocol?
    
    var router: PeopleRouterProtocol?
    
   
    func getDeptUuid(empUuid: String) {
        interactor?.getDeptUuid(empUuid: empUuid)
    }
    
    func getCompleteList() {
        interactor?.getCompleteList()
    }
    
    func getDepartmentList(deptUuid: String) {
        interactor?.getDepartmentList(deptUuid: deptUuid)
    }
    
    
}
extension PeoplePresenter : PeopleOutputInteractorProtocol {
    func updatedList(peopleDetails: [People]) {
        view?.updatedList(peopleDetails: peopleDetails)
    }
    
    func updatedDeptUuid(deptUuid: String) {
        view?.updatedDeptUuid(deptUuid: deptUuid)
    }
    
    
}
