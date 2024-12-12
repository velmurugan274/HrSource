//
//  LeaveTrackerRouter.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 30/05/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
import UIKit
class LeaveTrackerRouter : LeaveTrackerRouterProtocol {
    func presentApplyLeave(from view: UIViewController, with startDate : Double , with endDate: Double, with empUuid: String) {
        let leave = ApplyLeaveView()
        leave.empUuid = empUuid
        leave.selectFromDate.text = DateController.getDateFromTimeStamp(timeStamp: startDate)
        leave.fromDate = Int64(startDate)
        leave.selectToDate.text = DateController.getDateFromTimeStamp(timeStamp: endDate)
        leave.toDate = Int64(endDate)
        view.navigationController?.pushViewController(leave, animated: true)
    }
    
    static func createLeaveTrackerModule(leaveTrackerRef : LeaveTracker) {
        let presenter : LeaveTrackerOutputInteractorProtocol & LeaveTrackerPresenterProtocol = LeaveTrackerPresenter()
        
        leaveTrackerRef.presenter = presenter
        leaveTrackerRef.presenter?.interactor = LeaveInteracor()
        leaveTrackerRef.presenter?.view = leaveTrackerRef
        leaveTrackerRef.presenter?.router = LeaveTrackerRouter()
        leaveTrackerRef.presenter?.interactor?.presenter = presenter
    }
    
    
}
