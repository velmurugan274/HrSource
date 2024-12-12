//
//  Leave.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 30/05/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//


import Foundation
import  UIKit
protocol LeaveTrackerViewProtocol  {
    // PRESENTER -> VIEW
    func showLeaveDates(dates : [leaveDates])
}


protocol LeaveTrackerPresenterProtocol {
    //View -> Presenter
    var  interactor: LeaveTrackerInputInteractorProtocol? { get set }
    var view:  LeaveTrackerViewProtocol?  { get set }
    var router: LeaveTrackerRouterProtocol? { get set }
    
    func getLeaveDates(empUuid : String)
    func presentApplyLeave(from view : UIViewController, with startDate : Double , with endDate: Double, with empUuid : String)
    
}

protocol LeaveTrackerOutputInteractorProtocol {
    //Interactor -> Presenter
    func showLeaveDates(dates : [leaveDates])
    
}

protocol LeaveTrackerInputInteractorProtocol {
    
    //Presenter -> Interactor
    var presenter: LeaveTrackerOutputInteractorProtocol? { get set }
    func getLeaveDates(empUuid : String)
    
}


protocol LeaveTrackerRouterProtocol: class {
    //Presenter -> Wireframe
    func presentApplyLeave(from view : UIViewController, with startDate : Double , with endDate: Double , with empUuid : String)
    static func createLeaveTrackerModule(leaveTrackerRef : LeaveTracker)
}
