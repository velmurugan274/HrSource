
import Foundation
import  UIKit
protocol ApplyLeaveViewProtocol  {
    // PRESENTER -> VIEW
    func setDeptId(deptId : String)
    
}


protocol ApplyLeavePresenterProtocol {
    //View -> Presenter
    var  interactor: ApplyLeaveInputInteractorProtocol? { get set }
    var view:  ApplyLeaveViewProtocol?  { get set }
    var router: ApplyLeaveRouterProtocol? { get set }
    
    func updateLeave(leave : Leave)
    func getDeptId(empUuid :String )
    
    func presentHomeTab(from view : UIViewController, with empUuid  : String)
    
}

protocol ApplyLeaveOutputInteractorProtocol {
    //Interactor -> Presenter
    func setDeptId(deptId : String)
    
}

protocol ApplyLeaveInputInteractorProtocol {
    
    //Presenter -> Interactor
    var presenter: ApplyLeaveOutputInteractorProtocol? { get set }
    func updateLeave(leave : Leave)
    func getDeptId(empUuid : String)
    
}


protocol ApplyLeaveRouterProtocol: class {
    //Presenter -> Wireframe
    func presentHomeTab(from view: UIViewController, with empUuid  : String)
    static func createApplyLeaveModule(applyLeaveRef: ApplyLeaveView)
}
