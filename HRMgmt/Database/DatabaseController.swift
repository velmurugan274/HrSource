import Foundation
import SQLite3
class DatabaseController {
    typealias DB = Database
     var db : OpaquePointer?
    var sql : String?
    var stmt : OpaquePointer?
    var stmt1 : OpaquePointer?
    init(){
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("database.sqlite")
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("Error Opening Database")
            return
        }
        
        for tableQuery in DB.table {
            sql = tableQuery
            if sqlite3_exec(db, sql, nil, nil, nil) != SQLITE_OK {
                print("Error Creating Table")
                return
            }
            sqlite3_finalize(stmt)
            
        }
      //  sqlite3_finalize(stmt)
        
        sql="SELECT COUNT(*) from "+DB.TABLE_INSERT_COLUMNS;
        
        if sqlite3_prepare(db, sql, -1, &stmt, nil) == SQLITE_OK {
            if(sqlite3_step(stmt) == SQLITE_ROW) {
                if sqlite3_column_int(stmt, 0) == 0{
                    for updateValues in DB.UPDATECOLUMN {
                        sql = updateValues
                        if sqlite3_prepare(db, sql, -1, &stmt1, nil) == SQLITE_OK {
                            if sqlite3_step(stmt1) == SQLITE_DONE {
                                print("Updated.")
                                print("coming")
                            } else {
                                print("Nop...")
                            }
                            sqlite3_finalize(stmt1);
                        }
                        sqlite3_reset(stmt)
                    }
                    sql="INSERT INTO \(DB.TABLE_INSERT_COLUMNS) VALUES (1);";
                    if sqlite3_exec(db, sql, nil, nil, nil) != SQLITE_OK {
                        print("Error Creating Table")
                        return
                    }
                    sqlite3_reset(stmt)
                }
                

            }
            sqlite3_finalize(stmt);
           // sqlite3_close(db);
        }
        
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        print(paths[0])
        
        
    }
    
    func loginPresent(loginId : String) -> Bool{
        sql = "SELECT COUNT(*) FROM  \(DB.TABLE_EMPLOYEE ) WHERE \(DB.COLUMN_EMP_PHONE) = '\(loginId)' OR \(DB.COLUMN_EMP_MAIL) = '\(loginId)' "
        if sqlite3_prepare(db, sql, -1, &stmt, nil) == SQLITE_OK {
            if(sqlite3_step(stmt) == SQLITE_ROW) {
                if sqlite3_column_int(stmt, 0) > 0{
                    sqlite3_finalize(stmt);
                    sqlite3_close(db);
                    return true
                }
            }
        }
        sqlite3_finalize(stmt);
      //  sqlite3_close(db);
        
        return false
    }
    
    func getEmpName(empUuid : String) -> String{
        var name : String = ""
        sql = "SELECT \(DB.COLUMN_EMP_NAME) FROM  \(DB.TABLE_EMPLOYEE ) WHERE \(DB.COLUMN_UNIQUE_ID) = '\(empUuid)' "
        if sqlite3_prepare(db, sql, -1, &stmt, nil) == SQLITE_OK {
            if(sqlite3_step(stmt) == SQLITE_ROW) {
                name = String(cString:  sqlite3_column_text(stmt, 0))
            }
        }
        sqlite3_finalize(stmt);
        //  sqlite3_close(db);
        return name
    }
    
     func getEmpId(loginId : String) -> String{
        var uuid : String = ""
        sql = "SELECT \(DB.COLUMN_UNIQUE_ID) FROM  \(DB.TABLE_EMPLOYEE ) WHERE \(DB.COLUMN_EMP_PHONE) = '\(loginId)' OR \(DB.COLUMN_EMP_MAIL) = '\(loginId)' "
        if sqlite3_prepare(db, sql, -1, &stmt, nil) == SQLITE_OK {
            if(sqlite3_step(stmt) == SQLITE_ROW) {
                uuid = String(cString:  sqlite3_column_text(stmt, 0))
                print(uuid)
            }
        }
        sqlite3_finalize(stmt);
      //  sqlite3_close(db);
        return uuid
    }
    
    func getPeopleList() -> [People] {
        sql = " SELECT \(DB.COLUMN_EMP_NAME) , \(DB.COLUMN_EMP_POSITION) ,\(DB.COLUMN_DEPARTMENT_NAME) , \(DB.COLUMN_UNIQUE_ID) FROM \(DB.TABLE_EMPLOYEE)  INNER JOIN   \(DB.TABLE_DEPARTMENT)  ON  \(DB.TABLE_EMPLOYEE).\(DB.COLUMN_EMP_DEPT_ID)  =  \(DB.TABLE_DEPARTMENT).\(DB.COLUMN_DEPT_UUID) ORDER BY   \(DB.COLUMN_EMP_NAME);"
        var peopleList : [People] = [People]()
        print("\nUSER DETAILS\n")
        
        if sqlite3_prepare(db, sql, -1, &stmt, nil) == SQLITE_OK {
            while(sqlite3_step(stmt) == SQLITE_ROW) {
                let name = String(cString:  sqlite3_column_text(stmt, 0))
                let postion = String(cString:  sqlite3_column_text(stmt, 1))
                let department = String(cString:  sqlite3_column_text(stmt, 2))
                let uniqueId = String(cString:  sqlite3_column_text(stmt, 3))
                let people = People(name: name, position: postion, department: department, empUuid: uniqueId)
                peopleList.append(people)
            }
        }
        sqlite3_finalize(stmt);
      //  sqlite3_close(db);
        return peopleList
    }
    
    func getDepartmentList(deptUuid : String) -> [People] {
        sql = " SELECT \(DB.COLUMN_EMP_NAME) , \(DB.COLUMN_EMP_POSITION) ,\(DB.COLUMN_DEPARTMENT_NAME), \(DB.COLUMN_UNIQUE_ID)  FROM \(DB.TABLE_EMPLOYEE)  INNER JOIN   \(DB.TABLE_DEPARTMENT)  ON  \(DB.TABLE_EMPLOYEE).\(DB.COLUMN_EMP_DEPT_ID)  =  \(DB.TABLE_DEPARTMENT).\(DB.COLUMN_DEPT_UUID) WHERE \(DB.COLUMN_DEPT_UUID) = '\(deptUuid)' ORDER BY   \(DB.COLUMN_EMP_NAME);"
        var peopleList : [People] = [People]()
        print("\nUSER DETAILS\n")
        
        if sqlite3_prepare(db, sql, -1, &stmt, nil) == SQLITE_OK {
            while(sqlite3_step(stmt) == SQLITE_ROW) {
                let name = String(cString:  sqlite3_column_text(stmt, 0))
                print(name)
                let postion = String(cString:  sqlite3_column_text(stmt, 1))
                let department = String(cString:  sqlite3_column_text(stmt, 2))
                let uniqueId = String(cString:  sqlite3_column_text(stmt, 3))
                let people = People(name: name, position: postion, department: department, empUuid: uniqueId)
                peopleList.append(people)
                
            }
        }
        sqlite3_finalize(stmt);
        return peopleList
    }
    
    func getDeptUuid(empUuid : String) -> String {
        var deptUuid = ""
        sql = "SELECT \(DB.COLUMN_EMP_DEPT_ID) FROM \(DB.TABLE_EMPLOYEE) WHERE \(DB.COLUMN_UNIQUE_ID) = '\(empUuid)' "
        if sqlite3_prepare(db, sql, -1, &stmt, nil) == SQLITE_OK {
            if(sqlite3_step(stmt) == SQLITE_ROW) {
                deptUuid = String(cString:  sqlite3_column_text(stmt, 0))
            }
        }
        sqlite3_finalize(stmt);
        return deptUuid

    }
    
    func getReporterUuid(empUuid : String) -> String {
        var reporterId = ""
        sql = "SELECT \(DB.COLUMN_EMP_REPORTING_ID) FROM \(DB.TABLE_EMPLOYEE) WHERE \(DB.COLUMN_UNIQUE_ID) = '\(empUuid)' "
        if sqlite3_prepare(db, sql, -1, &stmt, nil) == SQLITE_OK {
            if(sqlite3_step(stmt) == SQLITE_ROW) {
                reporterId = String(cString:  sqlite3_column_text(stmt, 0))
            }
        }
        sqlite3_finalize(stmt);
        return reporterId
        
    }

    
    func getAllDeptUuid() -> [String] {
        var deptUuid = [String]()
        sql = "SELECT \(DB.COLUMN_DEPT_UUID) FROM \(DB.TABLE_DEPARTMENT) "
        if sqlite3_prepare(db, sql, -1, &stmt, nil) == SQLITE_OK {
            while(sqlite3_step(stmt) == SQLITE_ROW) {
                deptUuid.append(String(cString:  sqlite3_column_text(stmt, 0)))
            }
        }
        sqlite3_finalize(stmt);
        return deptUuid
        
    }
    
    func getReporterDetail(empUuid : String) -> People {
        var people = People(name: "-", position: "", department: "", empUuid: "-")
        sql = " SELECT \(DB.COLUMN_EMP_NAME) , \(DB.COLUMN_EMP_POSITION) ,\(DB.COLUMN_DEPARTMENT_NAME) , \(DB.COLUMN_UNIQUE_ID) FROM \(DB.TABLE_EMPLOYEE)  INNER JOIN   \(DB.TABLE_DEPARTMENT)  ON  \(DB.TABLE_EMPLOYEE).\(DB.COLUMN_EMP_DEPT_ID)  =  \(DB.TABLE_DEPARTMENT).\(DB.COLUMN_DEPT_UUID) WHERE \(DB.COLUMN_UNIQUE_ID) = '\(empUuid)';"
        if sqlite3_prepare(db, sql, -1, &stmt, nil) == SQLITE_OK {
            if(sqlite3_step(stmt) == SQLITE_ROW) {
                let name = String(cString:  sqlite3_column_text(stmt, 0))
                let postion = String(cString:  sqlite3_column_text(stmt, 1))
                let department = String(cString:  sqlite3_column_text(stmt, 2))
                let uniqueId = String(cString:  sqlite3_column_text(stmt, 3))
                people = People(name: name, position: postion, department: department, empUuid: uniqueId)

            }else {
                let errorMessage = String.init(cString: sqlite3_errmsg(db))
                print("Handled Error")
                print(errorMessage)
            }
        }
        sqlite3_finalize(stmt);
        return people
    }
    
    func getDirectReporters(empUuid : String) -> [People] {
        sql = " SELECT \(DB.COLUMN_EMP_NAME) , \(DB.COLUMN_EMP_POSITION) ,\(DB.COLUMN_DEPARTMENT_NAME), \(DB.COLUMN_UNIQUE_ID)  FROM \(DB.TABLE_EMPLOYEE)  INNER JOIN   \(DB.TABLE_DEPARTMENT)  ON  \(DB.TABLE_EMPLOYEE).\(DB.COLUMN_EMP_DEPT_ID)  =  \(DB.TABLE_DEPARTMENT).\(DB.COLUMN_DEPT_UUID) WHERE \(DB.TABLE_EMPLOYEE).\(DB.COLUMN_EMP_REPORTING_ID)  = '\(empUuid)' "
        var peopleList : [People] = [People]()
        if sqlite3_prepare(db, sql, -1, &stmt, nil) == SQLITE_OK {
            while(sqlite3_step(stmt) == SQLITE_ROW) {
                let name = String(cString:  sqlite3_column_text(stmt, 0))
                let postion = String(cString:  sqlite3_column_text(stmt, 1))
                let department = String(cString:  sqlite3_column_text(stmt, 2))
                let uniqueId = String(cString:  sqlite3_column_text(stmt, 3))
                let people = People(name: name, position: postion, department: department, empUuid: uniqueId)
                peopleList.append(people)
            }
        }
        sqlite3_finalize(stmt);
        return peopleList
    }
    
    func getTaskOwners(empUuid : String) -> [TaskOwners] {
        sql = " SELECT \(DB.COLUMN_EMP_NAME) , \(DB.COLUMN_UNIQUE_ID)  FROM \(DB.TABLE_EMPLOYEE)  INNER JOIN   \(DB.TABLE_DEPARTMENT)  ON  \(DB.TABLE_EMPLOYEE).\(DB.COLUMN_EMP_DEPT_ID)  =  \(DB.TABLE_DEPARTMENT).\(DB.COLUMN_DEPT_UUID) WHERE \(DB.TABLE_EMPLOYEE).\(DB.COLUMN_EMP_REPORTING_ID)  = '\(empUuid)' "
        var taskOwnerList : [TaskOwners] = [TaskOwners]()
        if sqlite3_prepare(db, sql, -1, &stmt, nil) == SQLITE_OK {
            while(sqlite3_step(stmt) == SQLITE_ROW) {
                let name = String(cString:  sqlite3_column_text(stmt, 0))
                let uniqueId = String(cString:  sqlite3_column_text(stmt, 1))
                let  taskOwner = TaskOwners(empUuid: uniqueId, empName: name)
                taskOwnerList.append(taskOwner)
            }
        }
        sqlite3_finalize(stmt);
        return taskOwnerList
    }
    
    func getSearchedList(search : String) -> [People]{
        sql = " SELECT \(DB.COLUMN_EMP_NAME) , \(DB.COLUMN_EMP_POSITION) ,\(DB.COLUMN_DEPARTMENT_NAME), \(DB.COLUMN_UNIQUE_ID)  FROM \(DB.TABLE_EMPLOYEE)  INNER JOIN   \(DB.TABLE_DEPARTMENT)  ON  \(DB.TABLE_EMPLOYEE).\(DB.COLUMN_EMP_DEPT_ID)  =  \(DB.TABLE_DEPARTMENT).\(DB.COLUMN_DEPT_UUID) WHERE ( \(DB.COLUMN_EMP_ID) LIKE '%\(search)%' OR \(DB.COLUMN_EMP_NAME) LIKE '%\(search)%' OR \(DB.COLUMN_EMP_MAIL) LIKE '%\(search)%' OR \(DB.COLUMN_EMP_PHONE)   LIKE '%\(search)%' )ORDER BY   \(DB.COLUMN_EMP_NAME);"
        var peopleList : [People] = [People]()
        print("\nUSER DETAILS\n")
        
        if sqlite3_prepare(db, sql, -1, &stmt, nil) == SQLITE_OK {
            while(sqlite3_step(stmt) == SQLITE_ROW) {
                let name = String(cString:  sqlite3_column_text(stmt, 0))
                let postion = String(cString:  sqlite3_column_text(stmt, 1))
                let department = String(cString:  sqlite3_column_text(stmt, 2))
                let uniqueId = String(cString:  sqlite3_column_text(stmt, 3))
                let people = People(name: name, position: postion, department: department, empUuid: uniqueId)
                peopleList.append(people)
            }
        }else {
            let errorMessage = String.init(cString: sqlite3_errmsg(db))
            print("Handled Error")
            print(errorMessage)
        }
        return peopleList
    }
    
    func getProfileDetails(empUuid : String) -> Profile {
        var profile : Profile?
        print(empUuid+"getting here")
        print(empUuid)
        sql = " SELECT \(DB.COLUMN_EMP_ID) ,\(DB.COLUMN_EMP_NAME) ,\(DB.COLUMN_EMP_PHONE) ,\(DB.COLUMN_EMP_MAIL), \(DB.COLUMN_EMP_STATUS), \(DB.COLUMN_DEPARTMENT_NAME), \(DB.COLUMN_EMP_POSITION) , \(DB.COLUMN_EMP_LOCATION), \(DB.COLUMN_EMP_REPORTING_ID)  FROM \(DB.TABLE_EMPLOYEE)  INNER JOIN   \(DB.TABLE_DEPARTMENT)  ON  \(DB.TABLE_EMPLOYEE).\(DB.COLUMN_EMP_DEPT_ID)  =  \(DB.TABLE_DEPARTMENT).\(DB.COLUMN_DEPT_UUID) WHERE \(DB.TABLE_EMPLOYEE).\(DB.COLUMN_UNIQUE_ID)  = '\(empUuid)' "
        
        if sqlite3_prepare(db, sql, -1, &stmt, nil) == SQLITE_OK {
            
            if(sqlite3_step(stmt) == SQLITE_ROW) {
                
                let empId = sqlite3_column_int(stmt, 0)
                let empName = String(cString:  sqlite3_column_text(stmt, 1))
                let empPhone = String(cString:  sqlite3_column_text(stmt, 2))
                let empMail = String(cString:  sqlite3_column_text(stmt, 3))
                let empStatus = Status(rawValue: String(cString:  sqlite3_column_text(stmt, 4)))
                let empDept = String(cString:  sqlite3_column_text(stmt, 5))
                let empPosition = String(cString:  sqlite3_column_text(stmt, 6))
                let empLocation = String(cString:  sqlite3_column_text(stmt, 7))
                let empReporting = String(cString:  sqlite3_column_text(stmt, 8))
                print(empReporting)
                profile = Profile(empId: Int(empId), empName: empName, telNumber: empPhone, mailId: empMail, status: empStatus!, department: empDept, empPosition: empPosition, location: empLocation,reportingId: empReporting)
                
            }
        }
        sqlite3_finalize(stmt);
        return profile!
    }
    
    func updateLeaveDetails(leave : Leave){
        sql  = "INSERT INTO  \(DB.TABLE_APPLIED_LEAVE)   ( \(DB.COLUMN_UNIQUE_ID)  ,  \(DB.COLUMN_REASON_ID) ,\(DB.COLUMN_LEAVE_START_DATE) ,  \(DB.COLUMN_LEAVE_END_DATE) ,  \(DB.COLUMN_LEAVE_DETAILS) ,\(DB.COLUMN_DEPARTMENT_ID) ) VALUES ('\(leave.getEmployeeId())', '\(leave.getLeaveType().rawValue)', \(leave.getStartDate()) , \(leave.getEndDate()) , '\(leave.getReason())' , '\(leave.getDeptId())');";
       
        print(sql)
        if sqlite3_prepare(db, sql, -1, &stmt, nil) == SQLITE_OK {
            if sqlite3_step(stmt) == SQLITE_DONE {
                print("Updated.")
                print("coming")
            } else {
                let errorMessage = String.init(cString: sqlite3_errmsg(db))
                print("Handled Error")
                print(errorMessage)
            }
        }else {
            let errorMessage = String.init(cString: sqlite3_errmsg(db))
            print("Handled Error")
            print(errorMessage)
        }
//        sql = "SELECT " + DB.COLUMN_EMP_NAME + " FROM " + DB.TABLE_EMPLOYEE + " WHERE " + DB.COLUMN_UNIQUE_ID + "='" + leave.getEmployeeId() + "'";
//        let empName : String?
//        if sqlite3_prepare(db, sql, -1, &stmt, nil) == SQLITE_OK {
//            if(sqlite3_step(stmt) == SQLITE_ROW) {
//                empName = String(cString:  sqlite3_column_text(stmt, 1))
//            }
//        }
        let leaveNotif = "I have applied for " + leave.getLeaveType().rawValue + " FROM " + DateController.getDateFromTimeStamp(timeStamp: Double(leave.getStartDate())) + " TO " + DateController.getDateFromTimeStamp(timeStamp: Double(leave.getEndDate())) + " for reason " + leave.getReason();
        sql = "INSERT INTO " + DB.TABLE_NOTIFICATION + " ( " + DB.COLUMN_NOTIF_SUBJECT + " , " + DB.COLUMN_NOTIF_DETAILS  + " , " + DB.COLUMN_NOTIF_SENDER_ID + "," + DB.COLUMN_NOTIF_DEPT + ","+DB.COLUMN_NOTIF_DATE+" ) VALUES ( 'LeaveNotification' , '" + leaveNotif + "','" + leave.getEmployeeId() + "','" + leave.getDeptId() + "', \(Int(Date().timeIntervalSince1970)));";
        print(sql)
        if sqlite3_prepare(db, sql, -1, &stmt, nil) == SQLITE_OK {
            if sqlite3_step(stmt) == SQLITE_DONE {
                print("Updated.")
                print("coming")
            } else {
                let errorMessage = String.init(cString: sqlite3_errmsg(db))
                print("Handled Error")
                print(errorMessage)
            }
        }
        
        
        sqlite3_finalize(stmt);
        
    }
    
    func setNotification(makeAnnouncement : MakeAnnouncement, empUuid : String){
        sql = "INSERT INTO " + DB.TABLE_NOTIFICATION + " ( " + DB.COLUMN_NOTIF_SUBJECT + " , " + DB.COLUMN_NOTIF_DETAILS  + " , " + DB.COLUMN_NOTIF_SENDER_ID + "," + DB.COLUMN_NOTIF_DEPT + ","+DB.COLUMN_NOTIF_DATE+" ) VALUES ( '\(makeAnnouncement.announcementTitle) ', '" + makeAnnouncement.announcementDetails + "','" + empUuid + "','\(makeAnnouncement.announcementDeptUuid)', \(Int(Date().timeIntervalSince1970) ));";
        print(sql)
        if sqlite3_prepare(db, sql, -1, &stmt, nil) == SQLITE_OK {
            if sqlite3_step(stmt) == SQLITE_DONE {
                print("Updated.")
                print("coming")
            } else {
                let errorMessage = String.init(cString: sqlite3_errmsg(db))
                print("Handled Error")
                print(errorMessage)
            }
        }
    }
    
    func getSecondsCount(date : Int, empUuid : String) -> Int{
        sql = "SELECT \(DB.COLUMN_CHECK_IN_TIME) , \(DB.COLUMN_CHECK_OUT_TIME) FROM  \(DB.TABLE_ATTENDANCE ) WHERE \(DB.COLUMN_UNIQUE_ID) = '\(empUuid)' AND \(DB.COLUMN_DATE_DETAILS) = \(date) "
        if sqlite3_prepare(db, sql, -1, &stmt, nil) == SQLITE_OK {
            if(sqlite3_step(stmt) == SQLITE_ROW) {
                let cin  = Int(sqlite3_column_int(stmt, 0))
                let cout  = Int(sqlite3_column_int(stmt, 1))
                print("Start")
                print(cin)
                print(cout)
                print("----")
                return (cout-cin)
            }
        }
        sqlite3_finalize(stmt);
        //  sqlite3_close(db);
        return 0
    }
    
    func getCurrentStatus(empUuid : String, date : Int) -> Status {
        sql = "SELECT \(DB.COLUMN_EMP_STATUS) FROM  \(DB.TABLE_EMPLOYEE)   WHERE ( \(DB.COLUMN_UNIQUE_ID)  = '\(empUuid)')";
//        print(sql)
        var status : Status?
        if sqlite3_prepare(db, sql, -1, &stmt, nil) == SQLITE_OK {
            if(sqlite3_step(stmt) == SQLITE_ROW) {
                status =  Status(rawValue: String(cString:  sqlite3_column_text(stmt, 0)))
                
            }
        }else {
            let errorMessage = String.init(cString: sqlite3_errmsg(db))
            print("Handled Error")
            print(errorMessage)
        }
        return status!
    }
    
    func changeCurrentStatus(empUuid : String) {
        let x = Date()
        let date = Int(x.timeIntervalSince1970)-(Int(x.timeIntervalSince1970)%86400)-19800
        let currentTime = Int(x.timeIntervalSince1970)
        sql = "SELECT COUNT(*) FROM \(DB.TABLE_ATTENDANCE)   WHERE ( \(DB.COLUMN_UNIQUE_ID)  = '\(empUuid)' AND   \(DB.COLUMN_DATE_DETAILS) = \(date) );";
        if sqlite3_prepare(db, sql, -1, &stmt, nil) == SQLITE_OK {
            if(sqlite3_step(stmt) == SQLITE_ROW) {
                if sqlite3_column_int(stmt, 0) == 0{
                  //  sqlite3_finalize(stmt);
                    sql = "UPDATE \( DB.TABLE_EMPLOYEE)  SET \(DB.COLUMN_EMP_STATUS) = '\(Status.checkIn.rawValue)' WHERE \(DB.COLUMN_UNIQUE_ID) ='\(empUuid)'"
                    if sqlite3_prepare(db, sql, -1, &stmt, nil) == SQLITE_OK {
                        if sqlite3_step(stmt) == SQLITE_DONE {
                            print("Updated1")
                        } else {
                            print("Nop...")
                        }
                    }else {
                        let errorMessage = String.init(cString: sqlite3_errmsg(db))
                        print("Handled Error")
                        print(errorMessage)
                    }
                    sql = "INSERT INTO \(DB.TABLE_ATTENDANCE) ( \(DB.COLUMN_UNIQUE_ID) , \(DB.COLUMN_DATE_DETAILS) ,\(DB.COLUMN_CHECK_IN_TIME) )   VALUES ('\(empUuid)',\(date),\(currentTime) )";
                    if sqlite3_prepare(db, sql, -1, &stmt, nil) == SQLITE_OK {
                        if sqlite3_step(stmt) == SQLITE_DONE {
                            print("Updated2")
                            print("coming")
                        } else {
                            let errorMessage = String.init(cString: sqlite3_errmsg(db))
                            print("Handled Error")
                            print(errorMessage)
                        }
                    }


                }
            else {
                sql = "SELECT " + DB.COLUMN_EMP_STATUS + " FROM " + DB.TABLE_EMPLOYEE + " WHERE " + DB.COLUMN_UNIQUE_ID + "='"+empUuid+"'";
                if sqlite3_prepare(db, sql, -1, &stmt, nil) == SQLITE_OK {
                    if(sqlite3_step(stmt) == SQLITE_ROW) {
                        if String(cString:  sqlite3_column_text(stmt, 0)) == "CHECK OUT"{
                            sqlite3_finalize(stmt);
                            sql = "UPDATE " + DB.TABLE_EMPLOYEE + " SET " + DB.COLUMN_EMP_STATUS + " ='CHECK IN' WHERE " + DB.COLUMN_UNIQUE_ID + " = '" + empUuid + "'";
                            if sqlite3_prepare(db, sql, -1, &stmt, nil) == SQLITE_OK {
                                if sqlite3_step(stmt) == SQLITE_DONE {
                                    print("Updated3")
                                } else {
                                    print("Nop...")
                                }
                                sqlite3_finalize(stmt);
                            }
                            sql = "UPDATE \(DB.TABLE_ATTENDANCE)  SET \(DB.COLUMN_CHECK_OUT_TIME) = '\(currentTime)' WHERE ( \(DB.COLUMN_UNIQUE_ID) = '\(empUuid)' AND \(DB.COLUMN_DATE_DETAILS)  =  \(date));";
                            if sqlite3_prepare(db, sql, -1, &stmt, nil) == SQLITE_OK {
                                print("Updated5")
                                if sqlite3_step(stmt) == SQLITE_DONE {
                                    print("Updated5")
                                } else {
                                    print("Nop...")
                                }
                                sqlite3_finalize(stmt);
                            }else {
                                print("updated 5")
                            }
                        } else {
                            sqlite3_finalize(stmt);
                            sql = "UPDATE " + DB.TABLE_EMPLOYEE + " SET " + DB.COLUMN_EMP_STATUS + "='CHECK OUT' WHERE " + DB.COLUMN_UNIQUE_ID + " = '"+empUuid+"'";
                            if sqlite3_prepare(db, sql, -1, &stmt, nil) == SQLITE_OK {
                                print("Updated4")
                                if sqlite3_step(stmt) == SQLITE_DONE {
                                    print("Updated4")
                                } else {
                                    print("Nop...")
                                }
                                sqlite3_finalize(stmt);
                            }else {
                                print("Updated4")
                            }
                            sql = "UPDATE \(DB.TABLE_ATTENDANCE)  SET \(DB.COLUMN_CHECK_OUT_TIME) = '\(currentTime)' WHERE ( \(DB.COLUMN_UNIQUE_ID) = '\(empUuid)' AND \(DB.COLUMN_DATE_DETAILS)  =  \(date));";
                            if sqlite3_prepare(db, sql, -1, &stmt, nil) == SQLITE_OK {
                                print("Updated5")
                                if sqlite3_step(stmt) == SQLITE_DONE {
                                    print("Updated5")
                                } else {
                                    print("Nop...")
                                }
                                sqlite3_finalize(stmt);
                            }else {
                                print("updated 5")
                            }
                            
                        }
                        
                    }
                }
                
            }
            }
        }

    }
    func checkPresent(empUuid : String, date : Int) -> Bool{
        sql = "SELECT COUNT(*) FROM \(DB.TABLE_ATTENDANCE)  WHERE ( \(DB.COLUMN_UNIQUE_ID)   = '\(empUuid)' AND  + \(DB.COLUMN_DATE_DETAILS)  =   \(date) )";
        if sqlite3_prepare(db, sql, -1, &stmt, nil) == SQLITE_OK {
            if(sqlite3_step(stmt) == SQLITE_ROW) {
                if sqlite3_column_int(stmt, 0) > 0{
                    print(Date(timeIntervalSince1970: Double(date)))
                    print("HELLO")
                    return false
                }
            }
        }
        if date == 1559500200 {
            print("dfksodfosjfosfjskldjfnksndjknsfnsjdbnksbnfksnfsfjsbdfkjsbkjabdkf")
        }
        return true
    }
    
    func getStartTime( date : Int, empUuid : String) -> Int{
        sql = "SELECT \(DB.COLUMN_CHECK_IN_TIME) FROM \(DB.TABLE_ATTENDANCE)  WHERE ( \(DB.COLUMN_UNIQUE_ID)   = '\(empUuid)' AND  + \(DB.COLUMN_DATE_DETAILS)  =   \(date) )";
        if sqlite3_prepare(db, sql, -1, &stmt, nil) == SQLITE_OK {
            if(sqlite3_step(stmt) == SQLITE_ROW) {
                let xyz : Int?
                xyz = Int(sqlite3_column_int(stmt, 0))
                if xyz != nil {
                    // Do something with xyz
                    return xyz!
                }else{
                    return 0
                }
                }
            }
        return 0
    }


    
    func getEndTime( date : Int, empUuid : String) -> Int{
        sql = "SELECT \(DB.COLUMN_CHECK_OUT_TIME) FROM \(DB.TABLE_ATTENDANCE)  WHERE ( \(DB.COLUMN_UNIQUE_ID)   = '\(empUuid)' AND  + \(DB.COLUMN_DATE_DETAILS)  =   \(date) )";
        if sqlite3_prepare(db, sql, -1, &stmt, nil) == SQLITE_OK {
            if(sqlite3_step(stmt) == SQLITE_ROW) {
                let xyz : Int?
                xyz = Int(sqlite3_column_int(stmt, 0))
                if xyz != nil {
                    // Do something with xyz
                    return xyz!
                }else{
                    return 0
                }
            }
        }
        return 0
    }
    
    
    
    func getLeaveType(empUuid : String, date : Int) -> String {
        sql = "SELECT \(DB.COLUMN_REASON_ID) FROM \(DB.TABLE_APPLIED_LEAVE)  WHERE ( \(DB.COLUMN_UNIQUE_ID)   = '\(empUuid)' AND   \(DB.COLUMN_LEAVE_START_DATE)  <= \(date) AND \(DB.COLUMN_LEAVE_END_DATE) >= \(date) )"
        if sqlite3_prepare(db, sql, -1, &stmt, nil) == SQLITE_OK {
            if(sqlite3_step(stmt) == SQLITE_ROW) {
                print(String(cString:  sqlite3_column_text(stmt, 0)))
               return String(cString:  sqlite3_column_text(stmt, 0))
            }
        }
        return "Absent"
    }
    func fetchLeaveDates(startDate: Int, endDate: Int) -> [Holiday]{
        var holidays = [Holiday]()
        sql = "SELECT \(DB.COLUMN_HOLIDAY_DATE), \(DB.COLUMN_HOLIDAY_TYPE), \(DB.COLUMN_HOLIDAY_REASON) FROM \(DB.TABLE_HOLIDAY_LIST) WHERE ( \(DB.COLUMN_HOLIDAY_DATE)>= \(startDate) AND \(DB.COLUMN_HOLIDAY_DATE)<= \(endDate) )"
        if sqlite3_prepare(db, sql, -1, &stmt, nil) == SQLITE_OK {
            while(sqlite3_step(stmt) == SQLITE_ROW) {
                let timeStamp = sqlite3_column_int(stmt, 0)
                let day = DateController.getDateDayFromTimeStamp(timeStamp: Double(timeStamp))
                let type = String(cString:  sqlite3_column_text(stmt, 1))
                let reason = String(cString:  sqlite3_column_text(stmt, 2))
                holidays.append(Holiday(date: day, type: type, reason: reason))
            }
        }
        return holidays
    }
    
    func getNotification(empUuid : String) -> [Notifications]{
        var notification = [Notifications]()
        sql = " SELECT \(DB.TABLE_NOTIFICATION).\(DB.COLUMN_NOTIF_ID), \(DB.COLUMN_NOTIF_SUBJECT), \(DB.COLUMN_NOTIF_DETAILS),\(DB.COLUMN_NOTIF_SENDER_ID), \(DB.COLUMN_NOTIF_LIKES), \(DB.COLUMN_NOTIF_STATUS), \(DB.COLUMN_NOTIF_DATE)   FROM (\(DB.TABLE_EMPLOYEE) INNER JOIN \(DB.TABLE_NOTIFICATION)  ON ( \(DB.TABLE_NOTIFICATION).\(DB.COLUMN_DEPARTMENT_ID)  =  \(DB.TABLE_EMPLOYEE).\(DB.COLUMN_DEPARTMENT_ID) AND  \(DB.COLUMN_NOTIF_SENDER_ID) !=  \(DB.COLUMN_UNIQUE_ID)) LEFT OUTER JOIN  \(DB.TABLE_READ_NOTIFICATION)  ON ( \(DB.TABLE_NOTIFICATION).\(DB.COLUMN_NOTIF_ID)  =  \(DB.TABLE_READ_NOTIFICATION).\(DB.COLUMN_NOTIF_ID) AND \(DB.TABLE_EMPLOYEE).\(DB.COLUMN_UNIQUE_ID) =  \(DB.TABLE_READ_NOTIFICATION).\(DB.COLUMN_NOTIF_READBY) )) WHERE ( \(DB.TABLE_EMPLOYEE).\(DB.COLUMN_UNIQUE_ID) = '\(empUuid)' ) ORDER BY \(DB.COLUMN_NOTIF_DATE) DESC ";
        print(sql)
        if sqlite3_prepare(db, sql, -1, &stmt, nil) == SQLITE_OK {
            
            while(sqlite3_step(stmt) == SQLITE_ROW) {
                
                let notifId = sqlite3_column_int(stmt, 0)
                let notifSubject = String(cString:  sqlite3_column_text(stmt, 1))
                let notifDetails = String(cString:  sqlite3_column_text(stmt, 2))
                let notifSenderId = String(cString:  sqlite3_column_text(stmt, 3))
                let xyz = sqlite3_column_text(stmt, 5)
                var notifStatus : NotifStatus?
                
                if xyz != nil {
                    // Do something with xyz
                     notifStatus = NotifStatus(rawValue: "read")
                }else{
                    notifStatus = NotifStatus(rawValue: "unread")
                }
                
                let notifLikes = sqlite3_column_int(stmt, 4)
                let notifDate = sqlite3_column_int(stmt, 6)
                notification.append(Notifications(notificationId: Int(notifId), notificationSubject: notifSubject, notificationBody: notifDetails, notificationSenderId: notifSenderId, notifLikes: Int(notifLikes), notifStatus: notifStatus!, notifdate: Int(notifDate)))
            }
            
        }
        return notification
    }
    
    func getIndividualNotification(empUuid : String) -> [Notifications]{
        var notification = [Notifications]()
        sql = " SELECT \(DB.COLUMN_NOTIF_ID), \(DB.COLUMN_NOTIF_SUBJECT), \(DB.COLUMN_NOTIF_DETAILS),\(DB.COLUMN_NOTIF_SENDER_ID), \(DB.COLUMN_NOTIF_LIKES), \(DB.COLUMN_NOTIF_STATUS), \(DB.COLUMN_NOTIF_DATE) FROM \(DB.TABLE_INDIVIDUAL_NOTIF) WHERE ( \(DB.COLUMN_NOTIF_RECIEVER_ID) = '\(empUuid)' ) ORDER BY \(DB.COLUMN_NOTIF_DATE) DESC ";
 
        print("hereeeee")
        if sqlite3_prepare(db, sql, -1, &stmt, nil) == SQLITE_OK {
            
            while(sqlite3_step(stmt) == SQLITE_ROW) {
                
                let notifId = sqlite3_column_int(stmt, 0)
                let notifSubject = String(cString:  sqlite3_column_text(stmt, 1))
                let notifDetails = String(cString:  sqlite3_column_text(stmt, 2))
                let notifSenderId = String(cString:  sqlite3_column_text(stmt, 3))
                let xyz = String(cString:  sqlite3_column_text(stmt, 5))
                var notifStatus : NotifStatus?
                
                if xyz == "read" {
                    // Do something with xyz
                    notifStatus = NotifStatus(rawValue: "read")
                }else{
                    notifStatus = NotifStatus(rawValue: "unread")
                }
                
                let notifLikes = sqlite3_column_int(stmt, 4)
                let notifDate = sqlite3_column_int(stmt, 6)
                notification.append(Notifications(notificationId: Int(notifId), notificationSubject: notifSubject, notificationBody: notifDetails, notificationSenderId: notifSenderId, notifLikes: Int(notifLikes), notifStatus: notifStatus!, notifdate: Int(notifDate)))
            }
            
        }
        return notification
    }
    
    func createTask(task :Task) {
        sql = "INSERT INTO \(DB.TABLE_TASK) ( \(DB.COLUMN_TASK_NAME) ,\(DB.COLUMN_TASK_EMPID) ,\(DB.COLUMN_TASK_DETAIL), \(DB.COLUMN_TASK_STARTDATE) ,\(DB.COLUMN_TASK_ENDDATE) ,\(DB.COLUMN_TASK_ASSIGNER), \(DB.COLUMN_TASK_STATUS), \(DB.COLUMN_TASK_ID) ) VALUES ('\(task.getTaskName())' , '\(task.getEmpId())' , '\(task.getTaskDetails())' , \(Int(task.getStartDate())) , \(Int(task.getEndDate())) , '\(task.getTaskAssigner())', '\(task.getTaskStatus().rawValue)' , '\(task.getTaskId())')"
        print(sql)

        if sqlite3_prepare(db, sql, -1, &stmt, nil) == SQLITE_OK {
            if sqlite3_step(stmt) == SQLITE_DONE {
                print("Updated2")
                print("coming")
            } else {
                let errorMessage = String.init(cString: sqlite3_errmsg(db))
                print("Handled Error")
                print(errorMessage)
            }
        }
        sql = "SELECT " + DB.COLUMN_EMP_NAME + " FROM " + DB.TABLE_EMPLOYEE + " WHERE " + DB.COLUMN_UNIQUE_ID + "='" + task.getTaskAssigner() + "'";
        var empName = ""
        if sqlite3_prepare(db, sql, -1, &stmt, nil) == SQLITE_OK {
            if(sqlite3_step(stmt) == SQLITE_ROW) {
                empName = String(cString:  sqlite3_column_text(stmt, 0))
            }
        }
       
        let taskDetails = "\(empName) have assinged you a task and make sure you complete the tasks given and inform them with proper notice. \n Thanks!!!"
        sql = "INSERT INTO \(DB.TABLE_INDIVIDUAL_NOTIF) (  \(DB.COLUMN_NOTIF_SUBJECT) ,  \(DB.COLUMN_NOTIF_DETAILS) , \(DB.COLUMN_NOTIF_SENDER_ID)  ,  \(DB.COLUMN_NOTIF_RECIEVER_ID) , \(DB.COLUMN_NOTIF_DATE) ) VALUES ( 'Task', '\(taskDetails)' ,'" + task.getTaskAssigner() + "','\(task.getEmpId())' , \(Int(Date().timeIntervalSince1970)) );";
        
        if sqlite3_prepare(db, sql, -1, &stmt, nil) == SQLITE_OK {
            if sqlite3_step(stmt) == SQLITE_DONE {
                print("Updated2")
                print("coming")
            } else {
                let errorMessage = String.init(cString: sqlite3_errmsg(db))
                print("Handled Error")
                print(errorMessage)
            }
        }
        sqlite3_finalize(stmt);
    }
    func getCompletedTask(empUuid : String) -> [Task]{
        var task = [Task]()
        sql = " SELECT \(DB.COLUMN_TASK_NAME) ,\(DB.COLUMN_TASK_EMPID) ,\(DB.COLUMN_TASK_DETAIL), \(DB.COLUMN_TASK_STARTDATE) ,\(DB.COLUMN_TASK_ENDDATE) ,\(DB.COLUMN_TASK_ASSIGNER), \(DB.COLUMN_TASK_ID) FROM \(DB.TABLE_TASK) WHERE (\(DB.COLUMN_TASK_EMPID) = '\(empUuid)' AND \(DB.COLUMN_TASK_STATUS) = '\(TaskStatus.completed.rawValue)')"
        if sqlite3_prepare(db, sql, -1, &stmt, nil) == SQLITE_OK {
            
            while(sqlite3_step(stmt) == SQLITE_ROW) {
                
                let taskName = String(cString:  sqlite3_column_text(stmt, 0))
                let taskEmpId = String(cString:  sqlite3_column_text(stmt, 1))
                let taskDetails = String(cString:  sqlite3_column_text(stmt, 2))
                let taskStartDate = Int64(sqlite3_column_int(stmt, 3))
                let taskEndDate = Int64(sqlite3_column_int(stmt, 4))
                let taskAssigner = String(cString:  sqlite3_column_text(stmt, 5))
                let taskId = String(cString:  sqlite3_column_text(stmt, 6))
 
                task.append(Task(empId: taskEmpId, taskName: taskName, taskDetails: taskDetails, startDate: taskStartDate, endDate: taskEndDate, taskStatus: .completed, taskAssigner: taskAssigner, taskId: taskId))
            }
            
        }
        return task
    }
    
    func getIncompleteTask(empUuid : String) -> [Task] {
        var task = [Task]()
        sql = " SELECT \(DB.COLUMN_TASK_NAME) ,\(DB.COLUMN_TASK_EMPID) ,\(DB.COLUMN_TASK_DETAIL), \(DB.COLUMN_TASK_STARTDATE) ,\(DB.COLUMN_TASK_ENDDATE) ,\(DB.COLUMN_TASK_ASSIGNER), \(DB.COLUMN_TASK_ID) FROM \(DB.TABLE_TASK) WHERE( \(DB.COLUMN_TASK_EMPID) = '\(empUuid)' AND \(DB.COLUMN_TASK_STATUS) = '\(TaskStatus.incomplete.rawValue)')"
        print(sql)
        if sqlite3_prepare(db, sql, -1, &stmt, nil) == SQLITE_OK {
            
            while(sqlite3_step(stmt) == SQLITE_ROW) {
                
                let taskName = String(cString:  sqlite3_column_text(stmt, 0))
                let taskEmpId = String(cString:  sqlite3_column_text(stmt, 1))
                let taskDetails = String(cString:  sqlite3_column_text(stmt, 2))
                let taskStartDate = Int64(sqlite3_column_int(stmt, 3))
                let taskEndDate = Int64(sqlite3_column_int(stmt, 4))
                let taskAssigner = String(cString:  sqlite3_column_text(stmt, 5))
                let taskId = String(cString:  sqlite3_column_text(stmt, 6))
                print(taskId)
                
                task.append(Task(empId: taskEmpId, taskName: taskName, taskDetails: taskDetails, startDate: taskStartDate, endDate: taskEndDate, taskStatus: .incomplete, taskAssigner: taskAssigner, taskId: taskId))
            }
            
        }
        return task
    }
    func checkHoliday(date : Int) -> Bool{
        sql = " SELECT COUNT(*)  FROM \(DB.TABLE_HOLIDAY_LIST) WHERE \(DB.COLUMN_HOLIDAY_DATE) = \(date)"
        print(date)
        if sqlite3_prepare(db, sql, -1, &stmt, nil) == SQLITE_OK {
            
            if(sqlite3_step(stmt) == SQLITE_ROW) {
                if sqlite3_column_int(stmt, 0) > 0 {
                    return true
                }else{
                 return false
                }
            }
            
        }
       
        return false
    }
    
    func updatePermission(permission : Permission) {
        
        sql = "SELECT " + DB.COLUMN_EMP_NAME + " FROM " + DB.TABLE_EMPLOYEE + " WHERE " + DB.COLUMN_UNIQUE_ID + "='" + permission.getEmpUuid() + "'";
        var empName = ""
        if sqlite3_prepare(db, sql, -1, &stmt, nil) == SQLITE_OK {
            if(sqlite3_step(stmt) == SQLITE_ROW) {
                empName = String(cString:  sqlite3_column_text(stmt, 0))
            }
        }
        var shiftChange = ""
        if permission.getShiftChange() {
            shiftChange = " He had also applied for shift Change ."
        }
        let permissionDetails = "\(empName) have applied for permission on \(DateController.getDateFromTimeStamp(timeStamp: Double(permission.getDate()))) and would enter the office by \(DateController.getTimeFromTimeStamp(timeStamp: Double(permission.getTime()))). \(shiftChange) "
        sql = "INSERT INTO \(DB.TABLE_INDIVIDUAL_NOTIF) (  \(DB.COLUMN_NOTIF_SUBJECT) ,  \(DB.COLUMN_NOTIF_DETAILS) , \(DB.COLUMN_NOTIF_SENDER_ID)  ,  \(DB.COLUMN_NOTIF_RECIEVER_ID) , \(DB.COLUMN_NOTIF_DATE) ) VALUES ( 'Permission ', '\(permissionDetails)' ,'" + permission.getEmpUuid() + "','\(permission.getReporterId())' , \(Int(Date().timeIntervalSince1970)) );";
        
        if sqlite3_prepare(db, sql, -1, &stmt, nil) == SQLITE_OK {
            if sqlite3_step(stmt) == SQLITE_DONE {
                print("Updated2")
                print("coming")
            } else {
                let errorMessage = String.init(cString: sqlite3_errmsg(db))
                print("Handled Error")
                print(errorMessage)
            }
        }
        sqlite3_finalize(stmt);
    }
    
    func updatePerformance(performance : Performance){
        sql = "INSERT INTO \(DB.TABLE_PERFORMANCE) (  \(DB.COLUMN_UNIQUE_ID) ,  \(DB.COLUMN_PERFORMANCE_DATE) , \(DB.COLUMN_PERFORMANCE_COMMENTS)  ,  \(DB.COLUMN_PERFORMANCE_ENTHUSAISM) , \(DB.COLUMN_PERFORMANCE_SPONTANITY) ,\(DB.COLUMN_PERFORMANCE_RESPONSIVENESS) ,\(DB.COLUMN_PERFORMANCE_TIME_MANAGEMENT) , \(DB.COLUMN_PERFORMANCE_OVERALL_PERFORMANCE) ) VALUES ( '\(performance.getEmpUuid())' , \(Int(Date().timeIntervalSince1970)), '\(performance.getComments())' , \(performance.getEnthusaism()) ,\(performance.getSpontanity()) , \(performance.getResponsiveness()),\(performance.getTimeManagement()), \(performance.getOverallPerformance()) )  ";
        
        if sqlite3_prepare(db, sql, -1, &stmt, nil) == SQLITE_OK {
            if sqlite3_step(stmt) == SQLITE_DONE {
                print("Updated2")
                print("coming")
            } else {
                let errorMessage = String.init(cString: sqlite3_errmsg(db))
                print("Handled Error")
                print(errorMessage)
            }
        }
        
        let performanceRating = "Your Manager have  updated your Performance Rating. your have got rating of \nEnthusaism = \(performance.getEnthusaism())/5 \nResponsiveness = \(performance.getResponsiveness())/5 \nTime Management = \(performance.getTimeManagement())/5 \nSpontanity = \(performance.getSpontanity())/5 \nOverallPerformance = \(performance.getOverallPerformance()) \nComments : \(performance.getComments())  "
        sql = "INSERT INTO \(DB.TABLE_INDIVIDUAL_NOTIF) (  \(DB.COLUMN_NOTIF_SUBJECT) ,  \(DB.COLUMN_NOTIF_DETAILS) , \(DB.COLUMN_NOTIF_SENDER_ID)  ,  \(DB.COLUMN_NOTIF_RECIEVER_ID) , \(DB.COLUMN_NOTIF_DATE) ) VALUES ( 'Performance Rating ', '\(performanceRating)' ,'" + performance.getEmpUuid() + "','\(performance.getEmpUuid())' , \(Int(Date().timeIntervalSince1970)) );";
        
        if sqlite3_prepare(db, sql, -1, &stmt, nil) == SQLITE_OK {
            if sqlite3_step(stmt) == SQLITE_DONE {
                print("Updated2")
                print("coming")
            } else {
                let errorMessage = String.init(cString: sqlite3_errmsg(db))
                print("Handled Error")
                print(errorMessage)
            }
        }
        sqlite3_finalize(stmt);
        
    }
    
    func getPerformance(empUuid : String) -> Performance{
        var performance = Performance(empUuid: empUuid, responsiveness: 0, spontanity: 0, timeManagement: 0, enthusaism: 0, overallPerformance: 0, comments: "Sorry no recent performance reviews to show")
        sql = "SELECT \(DB.COLUMN_PERFORMANCE_COMMENTS)  ,  \(DB.COLUMN_PERFORMANCE_ENTHUSAISM) , \(DB.COLUMN_PERFORMANCE_SPONTANITY) ,\(DB.COLUMN_PERFORMANCE_RESPONSIVENESS) ,\(DB.COLUMN_PERFORMANCE_TIME_MANAGEMENT) , \(DB.COLUMN_PERFORMANCE_OVERALL_PERFORMANCE) FROM \(DB.TABLE_PERFORMANCE) WHERE \(DB.COLUMN_UNIQUE_ID) = '\(empUuid)' ORDER BY \(DB.COLUMN_PERFORMANCE_DATE) DESC"
        if sqlite3_prepare(db, sql, -1, &stmt, nil) == SQLITE_OK {
            
            if(sqlite3_step(stmt) == SQLITE_ROW) {
                
                let comments = String(cString:  sqlite3_column_text(stmt, 0))
                let enthusaism = sqlite3_column_int(stmt, 1)
                let spoantanity = sqlite3_column_int(stmt, 2)
                let responsiveness = sqlite3_column_int(stmt, 3)
                let timeManagement = sqlite3_column_int(stmt, 4)
                let overallPerformance = sqlite3_column_int(stmt, 5)
                
                performance = Performance(empUuid: empUuid, responsiveness: Int(responsiveness), spontanity: Int(spoantanity), timeManagement: Int(timeManagement), enthusaism: Int(enthusaism), overallPerformance: Int(overallPerformance), comments: comments)
            }
            
        }
        sqlite3_finalize(stmt);
        return performance
    }
    
    func updateTask(taskId : String){
        sql = "UPDATE \( DB.TABLE_TASK)  SET \(DB.COLUMN_TASK_STATUS) = '\(TaskStatus.completed.rawValue)' WHERE \(DB.COLUMN_TASK_ID) ='\(taskId)'"
        if sqlite3_prepare(db, sql, -1, &stmt, nil) == SQLITE_OK {
            if sqlite3_step(stmt) == SQLITE_DONE {
                print("Updated1")
            } else {
                print("Nop...")
            }
        }else {
            let errorMessage = String.init(cString: sqlite3_errmsg(db))
            print("Handled Error")
            print(errorMessage)
        }
        sqlite3_finalize(stmt);
        
    }
    
    func checkIncharge(empUuid : String) -> Bool{
        sql = "SELECT COUNT(*) FROM \(DB.TABLE_QUERY_HANDLER) WHERE \(DB.COLUMN_QUERY_INCHARGE) = '\(empUuid)'"
        var check = false
        if sqlite3_prepare(db, sql, -1, &stmt, nil) == SQLITE_OK {
            
            if(sqlite3_step(stmt) == SQLITE_ROW) {
                let count = sqlite3_column_int(stmt, 0)
                if(count>0){
                check = true
                }
                else{
                check = false
                }
            }
        }
        sqlite3_finalize(stmt);
        return check
    }
    
    func getYourQueries(empUUid : String) -> [Query] {
        var queries = [Query]()
        sql = "SELECT \(DB.COLUMN_QUERY_ID), \(DB.COLUMN_QUERY_DATE), \(DB.COLUMN_QUERY_RECIEVER), \(DB.COLUMN_QUERY_SENDER), \(DB.COLUMN_QUERY_QUESTION), \(DB.COLUMN_QUERY_SUBJECT) FROM \(DB.TABLE_QUERY) WHERE \(DB.COLUMN_QUERY_SENDER) = '\(empUUid)'"
        if sqlite3_prepare(db, sql, -1, &stmt, nil) == SQLITE_OK {
            
            while(sqlite3_step(stmt) == SQLITE_ROW) {
                
                let queryId = String(cString:  sqlite3_column_text(stmt, 0))
                let queryDate = sqlite3_column_int(stmt, 1)
                let queryReciever = String(cString:  sqlite3_column_text(stmt, 2))
                let querySender = String(cString:  sqlite3_column_text(stmt, 3))
                let queryQuestion = String(cString:  sqlite3_column_text(stmt, 4))
                let querySubject = String(cString:  sqlite3_column_text(stmt, 5))
                
                queries.append(Query(queryId: queryId, senderId: querySender, recieverId: queryReciever, question: queryQuestion, questionSubject: querySubject, date: Int(queryDate)))
            }
            
        }
        sqlite3_finalize(stmt);
        return queries
    }
    
    func getQueriesToRespond(empUUid : String) -> [Query] {
        var queries = [Query]()
        sql = "SELECT \(DB.COLUMN_QUERY_ID), \(DB.COLUMN_QUERY_DATE), \(DB.COLUMN_QUERY_RECIEVER), \(DB.COLUMN_QUERY_SENDER), \(DB.COLUMN_QUERY_QUESTION), \(DB.COLUMN_QUERY_SUBJECT) FROM \(DB.TABLE_QUERY) WHERE \(DB.COLUMN_QUERY_RECIEVER) = '\(empUUid)'"
        if sqlite3_prepare(db, sql, -1, &stmt, nil) == SQLITE_OK {
            
            while(sqlite3_step(stmt) == SQLITE_ROW) {
                
                let queryId = String(cString:  sqlite3_column_text(stmt, 0))
                let queryDate = sqlite3_column_int(stmt, 1)
                let queryReciever = String(cString:  sqlite3_column_text(stmt, 2))
                let querySender = String(cString:  sqlite3_column_text(stmt, 3))
                let queryQuestion = String(cString:  sqlite3_column_text(stmt, 4))
                let querySubject = String(cString:  sqlite3_column_text(stmt, 5))
                
                queries.append(Query(queryId: queryId, senderId: querySender, recieverId: queryReciever, question: queryQuestion, questionSubject: querySubject, date: Int(queryDate)))
            }
            
        }
        sqlite3_finalize(stmt);
        return queries
    }
    
    func updateQueries(query : Query){
        sql = "INSERT INTO \(DB.TABLE_QUERY) ( \(DB.COLUMN_QUERY_ID), \(DB.COLUMN_QUERY_SENDER),\(DB.COLUMN_QUERY_RECIEVER),\(DB.COLUMN_QUERY_SUBJECT),\(DB.COLUMN_QUERY_QUESTION),\(DB.COLUMN_QUERY_DATE) ) VALUES ('\(query.getQueryId())','\(query.getSenderId())','\(query.getRecieverId())','\(query.getQuestionSubject())','\(query.getQuestion())',\(query.getDate())) "
        print(sql)
        if sqlite3_prepare(db, sql, -1, &stmt, nil) == SQLITE_OK {
            if sqlite3_step(stmt) == SQLITE_DONE {
                print("Updated2")
                print("coming")
            } else {
                let errorMessage = String.init(cString: sqlite3_errmsg(db))
                print("Handled Error")
                print(errorMessage)
            }
        }
        let Question  = "This query in asked to you regarding to follwing details \n \(query.getQuestion()) \n Please solve the query as soon as possible. ThankYou!"
        sql = "INSERT INTO \(DB.TABLE_INDIVIDUAL_NOTIF) (  \(DB.COLUMN_NOTIF_SUBJECT) ,  \(DB.COLUMN_NOTIF_DETAILS) , \(DB.COLUMN_NOTIF_SENDER_ID)  ,  \(DB.COLUMN_NOTIF_RECIEVER_ID) , \(DB.COLUMN_NOTIF_DATE) ) VALUES ( 'Query(\(query.getQuestionSubject())) ', '\(Question)' ,'" + query.getSenderId() + "','\(query.getRecieverId())' , \(Int(Date().timeIntervalSince1970)) );";
        
        if sqlite3_prepare(db, sql, -1, &stmt, nil) == SQLITE_OK {
            if sqlite3_step(stmt) == SQLITE_DONE {
                print("Updated2")
                print("coming")
            } else {
                let errorMessage = String.init(cString: sqlite3_errmsg(db))
                print("Handled Error")
                print(errorMessage)
            }
        }
        sqlite3_finalize(stmt);

    }
    
    func getQueryType() -> [queryIncharge] {
        var queryIncharges = [queryIncharge]()
        sql = "SELECT \(DB.COLUMN_QUERY_TYPE) , \(DB.COLUMN_QUERY_INCHARGE)  FROM \(DB.TABLE_QUERY_HANDLER)"
        if sqlite3_prepare(db, sql, -1, &stmt, nil) == SQLITE_OK {
            
            while(sqlite3_step(stmt) == SQLITE_ROW) {
                
                let queryType = String(cString:  sqlite3_column_text(stmt, 0))
                let empUuid = String(cString:  sqlite3_column_text(stmt, 1))
                queryIncharges.append(queryIncharge(queryType: queryType, empUuid: empUuid))
            }
            
        }
        sqlite3_finalize(stmt);
        return queryIncharges
    }
    
    func getQueryReplies(queryUuid : String) -> [QueryReplies] {
        var queryReplies = [QueryReplies]()
        sql = "SELECT \(DB.COLUMN_QUERY_ID), \(DB.COLUMN_QUERY_REPLIES), \(DB.COLUMN_REPLY_SENDER)  FROM \(DB.TABLE_QUERY_REPLIES) WHERE \(DB.COLUMN_QUERY_ID) = '\(queryUuid)' ORDER BY \(DB.COLUMN_QUERY_DATE) "
        if sqlite3_prepare(db, sql, -1, &stmt, nil) == SQLITE_OK {
            
            while(sqlite3_step(stmt) == SQLITE_ROW) {
                
                let replyId = String(cString:  sqlite3_column_text(stmt, 0))
                let replies = String(cString:  sqlite3_column_text(stmt, 1))
                let replySender = String(cString:  sqlite3_column_text(stmt, 2))
                queryReplies.append(QueryReplies(replyId: replyId, reply: replies, repliedBy: replySender))
            }
            print("Ama")
            
        }
        sqlite3_finalize(stmt);
        return queryReplies
    }
    
    func updateQueryReplies(queryReplies : QueryReplies) {
        sql = " INSERT INTO \(DB.TABLE_QUERY_REPLIES) ( \(DB.COLUMN_QUERY_ID), \(DB.COLUMN_QUERY_REPLIES), \(DB.COLUMN_REPLY_SENDER), \(DB.COLUMN_QUERY_DATE) ) VALUES( '\(queryReplies.getReplyId())', '\(queryReplies.getReply())', '\(queryReplies.getRepliedBy())', \(Int(Date().timeIntervalSince1970)) )"
        print(sql)
        if sqlite3_prepare(db, sql, -1, &stmt, nil) == SQLITE_OK {
            if sqlite3_step(stmt) == SQLITE_DONE {
                print("Updated2")
                print("coming")
            } else {
                let errorMessage = String.init(cString: sqlite3_errmsg(db))
                print("Handled Error")
                print(errorMessage)
            }
        }
        sqlite3_finalize(stmt);
    }
    func markIndividualStatusRead(notifId : Int) {
        sql = "UPDATE \( DB.TABLE_INDIVIDUAL_NOTIF)  SET \(DB.COLUMN_NOTIF_STATUS) = '\(NotifStatus.read.rawValue)' WHERE \(DB.COLUMN_NOTIF_ID) = \(notifId)"
        if sqlite3_prepare(db, sql, -1, &stmt, nil) == SQLITE_OK {
            if sqlite3_step(stmt) == SQLITE_DONE {
                print("Updated1")
            } else {
                print("Nop...")
            }
        }else {
            let errorMessage = String.init(cString: sqlite3_errmsg(db))
            print("Handled Error")
            print(errorMessage)
        }
        sqlite3_finalize(stmt);

    }
    func markNormalNotificationRead(notifId : Int, empUuid : String){
        sql = "INSERT INTO \(DB.TABLE_READ_NOTIFICATION) ( \(DB.COLUMN_NOTIF_ID) ,\(DB.COLUMN_NOTIF_READBY), \(DB.COLUMN_NOTIF_STATUS) ) VALUES( \(notifId) , '\(empUuid)', '\(NotifStatus.read.rawValue)')"
        if sqlite3_prepare(db, sql, -1, &stmt, nil) == SQLITE_OK {
            if sqlite3_step(stmt) == SQLITE_DONE {
                print("Updated2")
                print("coming")
            } else {
                let errorMessage = String.init(cString: sqlite3_errmsg(db))
                print("Handled Error")
                print(errorMessage)
            }
        }
        sqlite3_finalize(stmt);
    }
    func updateLikes(notifId : Int, empUUid : String){
        sql = " INSERT INTO \(DB.TABLE_NOTIF_LIKES) ( \(DB.COLUMN_NOTIF_ID) , \(DB.COLUMN_NOTIF_LIKER_ID) ) VALUES ( \(notifId) , '\(empUUid)')"
        if sqlite3_prepare(db, sql, -1, &stmt, nil) == SQLITE_OK {
            if sqlite3_step(stmt) == SQLITE_DONE {
                print("Updated2")
                print("coming")
            } else {
                let errorMessage = String.init(cString: sqlite3_errmsg(db))
                print("Handled Error")
                print(errorMessage)
            }
        }
        sql = " UPDATE \(DB.TABLE_NOTIFICATION) SET \(DB.COLUMN_NOTIF_LIKES) = (\(DB.COLUMN_NOTIF_LIKES) + 1) WHERE \(DB.COLUMN_NOTIF_ID) = \(notifId)"
        if sqlite3_prepare(db, sql, -1, &stmt, nil) == SQLITE_OK {
            if sqlite3_step(stmt) == SQLITE_DONE {
                print("Updated1")
            } else {
                print("Nop...")
            }
        }else {
            let errorMessage = String.init(cString: sqlite3_errmsg(db))
            print("Handled Error")
            print(errorMessage)
        }
        sqlite3_finalize(stmt);
    }
    func removeLike(notifId  : Int, empUuid: String){
        sql = " DELETE FROM \(DB.TABLE_NOTIF_LIKES)  WHERE \(DB.COLUMN_NOTIF_ID) = \(notifId) AND \(DB.COLUMN_NOTIF_LIKER_ID) = '\(empUuid)'"
        if sqlite3_prepare(db, sql, -1, &stmt, nil) == SQLITE_OK {
            if sqlite3_step(stmt) == SQLITE_DONE {
                print("Updated1")
            } else {
                print("Nop...")
            }
        }else {
            let errorMessage = String.init(cString: sqlite3_errmsg(db))
            print("Handled Error")
            print(errorMessage)
        }
        sql = " UPDATE \(DB.TABLE_NOTIFICATION) SET \(DB.COLUMN_NOTIF_LIKES) = (\(DB.COLUMN_NOTIF_LIKES) - 1) WHERE \(DB.COLUMN_NOTIF_ID) = \(notifId)"
        if sqlite3_prepare(db, sql, -1, &stmt, nil) == SQLITE_OK {
            if sqlite3_step(stmt) == SQLITE_DONE {
                print("Updated1")
            } else {
                print("Nop...")
            }
        }else {
            let errorMessage = String.init(cString: sqlite3_errmsg(db))
            print("Handled Error")
            print(errorMessage)
        }
        sqlite3_finalize(stmt);

    }
    func checkLiked(notifId : Int, empUuid : String) -> Bool{
        sql = " SELECT COUNT(*) FROM \(DB.TABLE_NOTIF_LIKES) WHERE \(DB.COLUMN_NOTIF_ID) = \(notifId) AND \(DB.COLUMN_NOTIF_LIKER_ID) = '\(empUuid)'"
        if sqlite3_prepare(db, sql, -1, &stmt, nil) == SQLITE_OK {
            
            if(sqlite3_step(stmt) == SQLITE_ROW) {
                if ( sqlite3_column_int(stmt, 0) > 0){
                    return true
                }else{
                    return false
                }
            }
        }
        sqlite3_finalize(stmt);
        return false
    }
    func checkNotifDetails(empUuid : String) -> Bool{
        var count = 0
         sql = " SELECT COUNT(*)  FROM (\(DB.TABLE_EMPLOYEE) INNER JOIN \(DB.TABLE_NOTIFICATION)  ON ( \(DB.TABLE_NOTIFICATION).\(DB.COLUMN_DEPARTMENT_ID)  =  \(DB.TABLE_EMPLOYEE).\(DB.COLUMN_DEPARTMENT_ID) AND  \(DB.COLUMN_NOTIF_SENDER_ID) !=  \(DB.COLUMN_UNIQUE_ID)) LEFT OUTER JOIN  \(DB.TABLE_READ_NOTIFICATION)  ON ( \(DB.TABLE_NOTIFICATION).\(DB.COLUMN_NOTIF_ID)  =  \(DB.TABLE_READ_NOTIFICATION).\(DB.COLUMN_NOTIF_ID) AND \(DB.TABLE_EMPLOYEE).\(DB.COLUMN_UNIQUE_ID) =  \(DB.TABLE_READ_NOTIFICATION).\(DB.COLUMN_NOTIF_READBY) )) WHERE ( \(DB.TABLE_EMPLOYEE).\(DB.COLUMN_UNIQUE_ID) = '\(empUuid)' AND \(DB.COLUMN_NOTIF_STATUS) IS NULL ) ";
        if sqlite3_prepare(db, sql, -1, &stmt, nil) == SQLITE_OK {
            
            if(sqlite3_step(stmt) == SQLITE_ROW) {
                count = (count+Int(sqlite3_column_int(stmt, 0) ))
       
                }
            }
        sql = " SELECT COUNT(*) FROM \(DB.TABLE_INDIVIDUAL_NOTIF) WHERE ( \(DB.COLUMN_NOTIF_RECIEVER_ID) = '\(empUuid)' AND \(DB.COLUMN_NOTIF_STATUS) = 'unread' ) ";
        if sqlite3_prepare(db, sql, -1, &stmt, nil) == SQLITE_OK {
            
            if(sqlite3_step(stmt) == SQLITE_ROW) {
                count = (count+Int(sqlite3_column_int(stmt, 0) ))
                
            }
        }
        sqlite3_finalize(stmt);
        print(count)
        if count > 0{
            return true
        }else{
            return false
        }
    }
    
    
    
    
}
