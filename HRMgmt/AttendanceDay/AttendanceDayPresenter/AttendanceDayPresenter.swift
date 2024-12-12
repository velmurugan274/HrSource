//
//  AttendanceDayPresenter.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 12/06/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
class AttendanceDayPresenter : AttendanceDayPresenterProtocol{
    var interactor: AttendanceDayInputInteractorProtocol?
    
    var view: AttendanceDayViewProtocol?
    
    var router: AttendanceDayRouterProtocol?
    
    func getAttendanceDay(startTime: Int, endTime: Int, date: Int) {
        interactor?.getAttendanceDay(startTime: startTime, endTime: endTime, date: date)
    }
    
   
    
    
}
extension AttendanceDayPresenter : AttendanceDayOutputInteractorProtocol {
    func updatedAttendanceDay(attendanceDay: AttendanceDay) {
        view?.UpdatedAttendanceDay(AttendanceDay: attendanceDay)
    }
}
