

import Foundation

enum  Gender : String {
    case male
    case female
    case others
}
enum Status : String {
    case checkIn = "CHECK IN"
    case checkOut = "CHECK OUT"
}


class Employee {
    private var empId : Int
    private var empName : String
    private var uniqueId : String
    private var telNumber : String
    private var mailId : String
    private var gender : Gender
    private var status : Status
    private var address : String
    private var reportingId : String
    private var department : Department
    private var location : String
    private var empPosition : String
    
    init(empId : Int, empName : String, uniqueId : String, telNumber : String,mailId : String ,gender : Gender, status : Status, address : String, reportingId : String, department : Department , empPosition : String, location : String){
        self.empId = empId
        self.empName = empName
        self.uniqueId = uniqueId
        self.telNumber = telNumber
        self.mailId = mailId
        self.gender = gender
        self.status = status
        self.address = address
        self.reportingId = reportingId
        self.department = department
        self.location = location
        self.empPosition = empPosition
    }
    
    func getEmpId() -> Int{
        return empId
    }
    
    func getEmpName() -> String {
        return empName
    }
    
    func getUniqueId() -> String {
        return uniqueId
    }
    
    func getTelNumber() -> String {
        return telNumber
    }
    
    func getMailId() -> String {
        return mailId
    }
    
    func getGender() -> Gender {
        return gender
    }
    
    func getStatus() -> Status {
        return status
    }
    
    func  getAddress() -> String {
        return address
    }
    
    func getReportingId() -> String {
        return reportingId
    }
    
    func getDepartment() -> Department {
        return department
    }
    
    func getLocation() -> String {
        return location
    }
    
    func getEmpPosition() -> String {
        return empPosition
    }
    
}
