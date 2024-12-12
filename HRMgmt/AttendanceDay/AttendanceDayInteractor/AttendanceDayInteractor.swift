//
//  AttendanceDayInteractor.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 12/06/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
class AttendanceDayInteractor : AttendanceDayInputInteractorProtocol{
    var presenter: AttendanceDayOutputInteractorProtocol?
    
    func getAttendanceDay(startTime: Int, endTime: Int, date: Int) {
        let activeHours = ((endTime-startTime)%86400)/3600
        let activeMinutes = (((endTime-startTime)%86400)%3600)/60
        
        var checkInTime = DateController.getTimeFromTimeStamp(timeStamp: Double(startTime))
        if(startTime == 0){
            checkInTime = "-"
        }
        var checkOutTime = DateController.getTimeFromTimeStamp(timeStamp: Double(endTime))
        if endTime == 0 {
            checkOutTime = "-"
        }
        let overTime : String?
        if(activeHours>=9){            
            overTime = " \(String(format: "%02d", activeHours-9)):\(String(format: "%02d", activeMinutes)) HRS"
        }else {
            overTime = "00:00 HRS"
        }
        let date = DateController.getDateFromTimeStamp(timeStamp: Double(date))
        let attendanceDay = AttendanceDay(activeHours: activeHours, activeMinutes: activeMinutes, checkInTime: checkInTime, checkOutTime: checkOutTime, overTime: overTime!, date: date)
        presenter?.updatedAttendanceDay(attendanceDay: attendanceDay)
        
    }
    
    
}
