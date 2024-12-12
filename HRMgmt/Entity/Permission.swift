//
//  Permission.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 28/05/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
class  Permission {
    private var date : Int
    private var empUuid : String
    private var reporterId : String
    private var shiftChange : Bool
    private var time : Int
    private var reason : String
    init(date : Int, shiftChange : Bool, time : Int, reason : String, empUuid : String, reporterId : String) {
        self.date = date
        self.shiftChange = shiftChange
        self.time = time
        self.empUuid = empUuid
        self.reason = reason
        self.reporterId = reporterId
    }
    func  getDate() -> Int {
        return date
    }
    func getShiftChange() -> Bool {
        return shiftChange
    }
    func  getTime() -> Int {
        return time
    }
    func getReason() -> String {
        return reason
    }
    func getEmpUuid() -> String {
        return empUuid
    }
    func getReporterId() -> String {
        return reporterId
    }
}
