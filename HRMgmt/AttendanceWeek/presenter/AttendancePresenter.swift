//
//  AttendancePresenter.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 30/05/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
import UIKit
class AttendanceWeekPresenter: AttendancePresenterProtocol {
    func pushAttendanceDay(view : UIViewController ,startTime: Int, endTime: Int, date: Int) {
        router?.pushAttendanceDay(view: view, startTime: startTime, endTime: endTime, date: date)
    }
    
    func getStartAndEndTime(date: Int, empUuid : String) {
        interactor?.getStartAndEndTime(date: date, empUuid : empUuid)
    }
    
    
    
    var interactor: AttendanceWeekInputInteractorProtocol?
    
    var view: AttendanceWeekViewProtocol?
    
    var router: AttendanceWeekRouterProtocol?
    
    func getDateDetails(date: Date, empUuid : String) {
        interactor?.getDateDetails(date: date, empUuid: empUuid)
    }

}
extension AttendanceWeekPresenter : AttendanceWeekOutputInteractorProtocol {
    func updatedDayDetails(dayDetails: calDates) {
        view?.updatedDayDetails(date: dayDetails)
    }
    func updatedStartAndEndTime(startTime: Int, endTime: Int) {
        view?.updatedStartAndEndTime(startTime: startTime, endTime: endTime)
    }
    
    
}
