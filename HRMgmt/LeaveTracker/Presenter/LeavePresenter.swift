//
//  LeavePresenter.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 30/05/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
import  UIKit
class LeaveTrackerPresenter : LeaveTrackerPresenterProtocol {
   
    var interactor: LeaveTrackerInputInteractorProtocol?
    
    var view: LeaveTrackerViewProtocol?
    
    var router: LeaveTrackerRouterProtocol?
    
    
    func presentApplyLeave(from view : UIViewController, with startDate : Double , with endDate: Double, with empUuid : String) {
        router?.presentApplyLeave(from: view, with: startDate, with: endDate, with: empUuid)
    }
    
    func getLeaveDates(empUuid: String) {
        interactor?.getLeaveDates(empUuid: empUuid)
    
    }
    
        
}
extension LeaveTrackerPresenter : LeaveTrackerOutputInteractorProtocol {
    func showLeaveDates(dates: [leaveDates]) {
        view?.showLeaveDates(dates: dates)
    }
    
    
}
