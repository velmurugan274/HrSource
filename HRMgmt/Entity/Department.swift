

import Foundation

class Department {
    private var departmentName : String
    private var departmentHead : String
    private var deptUuid : String
    private var deptDescription : String
    private var deptId : Int
    private var deptMail : String
    
    init(departmentName : String, departmentHead : String, deptUuid : String, deptDescription :String, deptId : Int , deptMail : String){
        self.departmentName = departmentName
        self.departmentHead = departmentHead
        self.deptUuid = deptUuid
        self.deptDescription = deptDescription
        self.deptId = deptId
        self.deptMail = deptMail
    }
    
    func getDepartmentName() -> String {
        return departmentName
    }
    
    func getDepartmentHead() -> String {
        return departmentHead
    }
    
    func getDeptUuid() -> String {
        return deptUuid
    }
    
    func getDeptDescription() -> String{
        return deptDescription
    }
    
    func getdeptId() -> Int {
        return deptId
    }
    
    func getDeptMail() -> String {
        return deptMail
    }
}
