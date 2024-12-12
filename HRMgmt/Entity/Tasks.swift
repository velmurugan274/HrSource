//
//  Task.swift
//  zpeople
//
//  Created by vel-pt2332 on 15/05/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
enum TaskStatus : String{
    case completed = "Completed"
    case incomplete = "Incomplete"
}

class Task {
    private var empId : String
    private var taskName : String
    private var taskAssigner : String
    private var taskDetails : String
    private var startDate : Int64
    private var endDate : Int64
    private var taskStatus : TaskStatus
    private var taskId :  String
    
    init(empId : String, taskName :String , taskDetails: String, startDate : Int64, endDate : Int64, taskStatus : TaskStatus, taskAssigner : String, taskId : String){
        self.empId = empId
        self.taskName = taskName
        self.taskDetails = taskDetails
        self.startDate = startDate
        self.endDate = endDate
        self.taskStatus = taskStatus
        self.taskAssigner = taskAssigner
        self.taskId = taskId
    }
    
    func getTaskId() -> String{
        return taskId
    }
    
    func getEmpId() -> String{
        return empId
    }
    
    func getTaskName() -> String {
        return taskName
    }
    
    func getTaskDetails() -> String {
        return taskDetails
    }
    
    func getStartDate() -> Int64 {
        return startDate
    }
    
    func getEndDate() -> Int64 {
        return endDate
    }
    
    func  getTaskStatus() -> TaskStatus {
        return taskStatus
    }
    func getTaskAssigner() -> String {
        return taskAssigner
    }
    
}
