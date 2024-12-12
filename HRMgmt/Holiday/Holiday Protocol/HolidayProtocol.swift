
import Foundation
import  UIKit
protocol  HolidayViewProtocol  {
    // PRESENTER -> VIEW
    func updatedLeaveDate(leaveDates : [Holiday])
    
}


protocol  HolidayPresenterProtocol {
    //View -> Presenter
    var  interactor:  HolidayInputInteractorProtocol? { get set }
    var view:   HolidayViewProtocol?  { get set }
    var router:  HolidayRouterProtocol? { get set }
    
    func getLeaveDates(year : Int)
    
    
}

protocol  HolidayOutputInteractorProtocol {
    //Interactor -> Presenter
    func updatedLeaveDate(leaveDates : [Holiday])
    
}

protocol  HolidayInputInteractorProtocol {
    
    //Presenter -> Interactor
    var presenter:  HolidayOutputInteractorProtocol? { get set }
    func getLeaveDates(year : Int)
}


protocol  HolidayRouterProtocol: class {
    //Presenter -> Wireframe

    static func createHolidayModule( holidayRef:  HolidayView)
}

class Holiday {
    var date : String?
    var type : String?
    var reason : String?
    init(date : String, type : String, reason : String) {
        self.date = date
        self.type = type
        self.reason = reason
    }
    
    
}
