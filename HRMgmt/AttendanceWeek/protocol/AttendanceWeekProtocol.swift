import Foundation
import  UIKit
protocol AttendanceWeekViewProtocol  {
    // PRESENTER -> VIEW
    func updatedDayDetails(date : calDates)
    func updatedStartAndEndTime(startTime : Int, endTime : Int)
    
}


protocol AttendancePresenterProtocol {
    //View -> Presenter
    var  interactor: AttendanceWeekInputInteractorProtocol? { get set }
    var view:  AttendanceWeekViewProtocol?  { get set }
    var router: AttendanceWeekRouterProtocol? { get set }
    
    
    func getDateDetails(date : Date, empUuid  : String)
    func getStartAndEndTime(date : Int, empUuid : String)
    func updatedStartAndEndTime(startTime : Int, endTime : Int)
    func pushAttendanceDay(view : UIViewController, startTime : Int, endTime : Int, date : Int)
   // func presentAttendanceDay(from view : UIViewController)
    
}

protocol AttendanceWeekOutputInteractorProtocol {
    //Interactor -> Presenter
    func updatedDayDetails(dayDetails : calDates)
    func updatedStartAndEndTime(startTime : Int, endTime : Int)
    
}

protocol AttendanceWeekInputInteractorProtocol {
    
    //Presenter -> Interactor
    var presenter: AttendanceWeekOutputInteractorProtocol? { get set }
    func getDateDetails(date : Date, empUuid : String)
    func getStartAndEndTime(date : Int, empUuid : String)
    
}


protocol AttendanceWeekRouterProtocol: class {
    //Presenter -> Wireframe
    func pushAttendanceDay( view : UIViewController ,startTime : Int, endTime : Int, date : Int)
    
}

