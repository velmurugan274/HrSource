import Foundation
import  UIKit
protocol AttendanceDayViewProtocol  {
    // PRESENTER -> VIEW
    func UpdatedAttendanceDay(AttendanceDay : AttendanceDay)
    
    
}


protocol AttendanceDayPresenterProtocol {
    //View -> Presenter
    var  interactor: AttendanceDayInputInteractorProtocol? { get set }
    var view:  AttendanceDayViewProtocol?  { get set }
    var router: AttendanceDayRouterProtocol? { get set }
    
    func getAttendanceDay(startTime : Int, endTime : Int, date : Int)

    
    
}

protocol AttendanceDayOutputInteractorProtocol {
    //Interactor -> Presenter
    func updatedAttendanceDay(attendanceDay : AttendanceDay)
    
}

protocol AttendanceDayInputInteractorProtocol {
    
    //Presenter -> Interactor
    var presenter: AttendanceDayOutputInteractorProtocol? { get set }
    func getAttendanceDay(startTime : Int, endTime : Int, date : Int)
    
}


protocol AttendanceDayRouterProtocol: class {
    //Presenter -> Wireframe
    static func createAttendanceDayModule(attendanceDayRef: AttendanceDayView)
}
