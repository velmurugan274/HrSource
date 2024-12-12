//
//  Attendacne.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 30/05/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
import UIKit
class AttendanceWeekRouter : AttendanceWeekRouterProtocol {
    func pushAttendanceDay(view : UIViewController ,startTime: Int, endTime: Int, date: Int) {
        let attendanceDay = AttendanceDayView()
        attendanceDay.date = date
        attendanceDay.startTime = startTime
        attendanceDay.endTime = endTime
        view.navigationController?.pushViewController(attendanceDay, animated: true)
    }
    
    
    class func createAttendanceWeekModule(attendacneWeekRef: Attendance) {
        let presenter : AttendanceWeekOutputInteractorProtocol  & AttendancePresenterProtocol = AttendanceWeekPresenter()
        attendacneWeekRef.presenter = presenter
        attendacneWeekRef.presenter?.interactor = AttendanceWeekInteractor()
        attendacneWeekRef.presenter?.view = attendacneWeekRef
        attendacneWeekRef.presenter?.router = AttendanceWeekRouter()
        attendacneWeekRef.presenter?.interactor?.presenter = presenter
        
    }

}
