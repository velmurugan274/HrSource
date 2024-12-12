
import Foundation
class Performance {
    private var empUuid : String
    private var responsiveness : Int
    private var spontanity : Int
    private var timeManagement : Int
    private var enthusaism : Int
    private var overallPerformance : Int
    private var comments : String
    init(empUuid : String, responsiveness :Int , spontanity :Int, timeManagement : Int , enthusaism  : Int, overallPerformance :Int , comments : String) {
        self.empUuid = empUuid
        self.responsiveness = responsiveness
        self.spontanity = spontanity
        self.timeManagement = timeManagement
        self.enthusaism = enthusaism
        self.overallPerformance = overallPerformance
        self.comments = comments
    }
    
    func getResponsiveness() -> Int {
        return responsiveness
    }
    func getSpontanity() -> Int {
        return spontanity
    }
    func getTimeManagement() -> Int {
        return timeManagement
    }
    func getEnthusaism() -> Int {
        return enthusaism
    }
    func getOverallPerformance() -> Int {
        return overallPerformance
    }
    func getComments() -> String {
        return comments
    }
    func getEmpUuid() -> String {
        return empUuid
    }
}
