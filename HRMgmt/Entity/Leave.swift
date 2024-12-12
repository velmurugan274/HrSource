//
//  Leave.swift
//  zpeople
//
//  Created by vel-pt2332 on 14/05/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation

enum LeaveType : String {
    case compensatoryOff = "Compensatory Off"
    case longLeave = "Long Leave"
    case teamTrip = "Team Trip"
    case optionalLeave = "Optional Leave"
}
class Leave {
    private var employeeId : String
    private var leaveType : LeaveType
    private var startDate : Int64
    private var endDate : Int64
    private var deptId : String
    private var reason : String
    
    init(employeeId : String, leaveType: LeaveType, startDate: Int64, endDate : Int64, deptId : String, reason : String){
        self.employeeId = employeeId
        self.leaveType = leaveType
        self.startDate = startDate
        self.endDate = endDate
        self.deptId = deptId
        self.reason = reason
    }
    
    func getEmployeeId() -> String {
        return employeeId
    }
    
    func getLeaveType() -> LeaveType{
        return leaveType
    }
    
    func getStartDate()-> Int64 {
        return startDate
    }
    
    func getEndDate()-> Int64 {
        return endDate
    }
    
    func getDeptId() -> String {
        return deptId
    }
    
    func  getReason() -> String {
        return reason
    }
}
