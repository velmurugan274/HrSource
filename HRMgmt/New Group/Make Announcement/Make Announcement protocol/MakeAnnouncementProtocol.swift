
import Foundation
import  UIKit
protocol MakeAnnouncementViewProtocol  {
    // PRESENTER -> VIEW
    func setDeptId(deptId : String)
    func setAllDept(allDept : [String])
    
}


protocol MakeAnnouncementPresenterProtocol {
    //View -> Presenter
    var  interactor: MakeAnnouncementInputInteractorProtocol? { get set }
    var view:  MakeAnnouncementViewProtocol?  { get set }
    var router: MakeAnnouncementRouterProtocol? { get set }
    
    func updateAnnoucement(announcement : MakeAnnouncement, empUuid : String)
    func getDeptId(empUuid :String )
    func getAllDept()
    
    func presentHomeTab(from view : UIViewController, with empUuid  : String)
    
}

protocol MakeAnnouncementOutputInteractorProtocol {
    //Interactor -> Presenter
    func setDeptId(deptId : String)
    func setAllDept(deptId : [String])
    
}

protocol MakeAnnouncementInputInteractorProtocol {
    
    //Presenter -> Interactor
    var presenter: MakeAnnouncementOutputInteractorProtocol? { get set }
    func updateAnnoucement(announcement : MakeAnnouncement, empUuid : String)
    func getDeptId(empUuid : String)
    func getAllDept()
    
}


protocol MakeAnnouncementRouterProtocol: class {
    //Presenter -> Wireframe
    func presentHomeTab(from view: UIViewController, with empUuid  : String)
    static func createMakeAnnouncementModule(makeAnnouncementRef: MakeAnnouncementView)
}

