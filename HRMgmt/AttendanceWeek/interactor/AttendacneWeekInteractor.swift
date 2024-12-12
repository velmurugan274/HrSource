//
//  File.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 29/05/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
import UIKit
class AttendanceWeekInteractor : AttendanceWeekInputInteractorProtocol {
    func getStartAndEndTime(date: Int, empUuid : String) {
        let startTime = db.getStartTime(date : date, empUuid : empUuid)
        let endTime = db.getEndTime(date :date, empUuid : empUuid)
        presenter?.updatedStartAndEndTime(startTime: startTime, endTime: endTime)
    }
    
    var presenter: AttendanceWeekOutputInteractorProtocol?
    
    func getDateDetails(date: Date, empUuid : String) {
        let dateDetils = setDates(date : date, empUuid :empUuid)
        presenter?.updatedDayDetails(dayDetails: dateDetils)
    }
    
 
    
    private func setDates(date : Date, empUuid : String) -> calDates {
        
        var dateList = calDates()
        //  print(date)
        dateList.dateStamp.removeAll()
        dateList.dates.removeAll()
        dateList.months.removeAll()
        dateList.hoursCount.removeAll()
        dateList.holiday.removeAll()
        let format = DateFormatter()
        let format2 = DateFormatter()
        let format3 = DateFormatter()
        format.dateFormat = "dd"
        //   let formattedDate = format.string(from: date)
        format2.dateFormat = "dd MMM"
        format3.dateFormat = "MMM"
        format.timeZone = (NSTimeZone(name: "IST")! as TimeZone)
        format2.timeZone = (NSTimeZone(name: "IST")! as TimeZone)
        format3.timeZone = (NSTimeZone(name: "IST")! as TimeZone)
    
        let dayCount = Calendar.current.component(.weekday, from: date)
        print(dayCount)
        var i=dayCount-1
        while i >= 0  {
            
            let newdate = Calendar.current.date(byAdding: .day, value: -i, to: date)
            var dateNow = Int((newdate?.timeIntervalSince1970)!)
            print(dateNow)
            dateNow = dateNow - (dateNow%86400) - 19800
            dateList.dateStamp.append(dateNow)
            let secCount = db.getSecondsCount(date : dateNow, empUuid : empUuid)
            //print("secCount \(dateNow)")
            if(i==dayCount-1){
                dateList.headDates = dateList.headDates + format2.string(from: newdate!)
                dateList.previousDate = newdate!
            }
            if(secCount>0){
                dateList.hoursCount.append( String(format: "%02d", secCount/3600)+":"+String(format: "%02d", (secCount%3600)/60))
            }else{
                dateList.hoursCount.append("00:00")
            }
            
            dateList.dates.append(Int(format.string(from: newdate!))!)
            dateList.months.append(format3.string(from: newdate!))
            dateList.holiday.append(db.checkHoliday(date: dateNow))
           // print("\(dateList.hoursCount) \(newdate!) \(dateList.dates)")
            i=i-1
        }
        i=1
        if dayCount == 7 {
            dateList.headDates = dateList.headDates + " - \(format2.string(from: date))"
            dateList.nextDate = date
        }
        
        while i <= (7-dayCount){
            
            let newdate = Calendar.current.date(byAdding: .day, value: i, to: date)
            var date = Int((newdate?.timeIntervalSince1970)!)
            date = date - (date%86400) - 19800
            dateList.dateStamp.append(date)
            let secCount = db.getSecondsCount(date : date, empUuid : empUuid)
            //     print(newdate)
            if(i==7-dayCount){
                dateList.headDates = dateList.headDates + " - \(format2.string(from: newdate!))"
                dateList.nextDate = newdate!
            }
            if(secCount>0){
                dateList.hoursCount.append( String(format: "%02d", secCount/3600)+":"+String(format: "%02d", (secCount%3600)/60))
            }else{
               // print("\(i) comes")
                dateList.hoursCount.append("00:00")
            }
            
            dateList.dates.append(Int(format.string(from: newdate!))!)
            dateList.months.append(format3.string(from: newdate!))
            dateList.holiday.append(db.checkHoliday(date: date))
            i =  i+1
           // print("\(dateList.hoursCount) \(date) \(dateList.dates)")
        }
        
        return dateList
    }
}
