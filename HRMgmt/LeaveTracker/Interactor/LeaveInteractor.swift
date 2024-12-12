//
//  LeaveInteractor.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 30/05/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
import UIKit
class LeaveInteracor : LeaveTrackerInputInteractorProtocol {
    var presenter: LeaveTrackerOutputInteractorProtocol?

    
    func getLeaveDates(empUuid: String) {
        let leaveDates = fetchLeaveDates(empUuid : empUuid)
        presenter?.showLeaveDates(dates: leaveDates)
    }
    func fetchLeaveDates(empUuid : String) -> [leaveDates] {
        var leaves = [leaveDates]()
        let date = Date()
        var x = Int(date.timeIntervalSince1970)
        x = x - (x%86400) - 19800 - 86400
        print(Date(timeIntervalSince1970: Double(x)))
        let end = x-(86400*30)
        print(x)
        print((x-(86400*30)))
        print("count")
        while x >= end{
            
            var dc = Calendar.current.component(.weekday, from: Date(timeIntervalSince1970: Double(x+19800)))

            if  db.checkPresent(empUuid: empUuid, date: x)  && dc != 1 && dc != 7  {
                let endDate = x
                var startDate = x
                let type = db.getLeaveType(empUuid: empUuid, date: x)
                for i in 0...4{
                    dc = Calendar.current.component(.weekday, from: Date(timeIntervalSince1970: Double(x+19800)))
                    print("\(dc) came outside \(i)")
                    print(Date(timeIntervalSince1970: Double(x)))
                    if db.checkPresent(empUuid: empUuid, date: x) && dc != 1 && dc != 7 {

                        if db.getLeaveType(empUuid: empUuid, date: endDate-(86400*i)) == type {
                       
                            startDate = (endDate - (i*86400))
                            x = (x-86400)
                        }
                        else{
                            x = (x+86400)
                            break
                        }
                    } else{
                        
                        if dc == 1 || dc == 7{
                        //    startDate = x+86400
                        }
                        if !(db.checkPresent(empUuid: empUuid, date: x)) {
                      //  startDate = (x+86400)
                        }
                      
                        break
                    }
                }

                leaves.append(leaveDates(startDate: startDate, endDate: endDate, leaveType: type))
                print(Date(timeIntervalSince1970: Double(startDate)))
                print("\(DateController.getDateFromTimeStamp(timeStamp: Double(startDate))) - \(DateController.getDateFromTimeStamp(timeStamp: Double(endDate)))")
            }
            x = (x-86400)
            print("=====================")
        }
        return leaves
    }

    
}
