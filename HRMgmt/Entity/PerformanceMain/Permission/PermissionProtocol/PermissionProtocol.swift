//

import Foundation
import  UIKit
protocol PermissionViewProtocol  {
    // PRESENTER -> VIEW
    func setReporterId(empUuid : String)
    
}


protocol PermissionPresenterProtocol {
    //View -> Presenter
    var  interactor: PermissionInputInteractorProtocol? { get set }
    var view:  PermissionViewProtocol?  { get set }
    var router: PermissionRouterProtocol? { get set }
    
    func updatePermission(permission : Permission)
    func getReporterId(empUuid :String )
    
    func presentHomeTab(from view : UIViewController, with empUuid  : String)
    
}

protocol PermissionOutputInteractorProtocol {
    //Interactor -> Presenter
    func setReporterId(empUuid : String)
    
}

protocol PermissionInputInteractorProtocol {
    
    //Presenter -> Interactor
    var presenter: PermissionOutputInteractorProtocol? { get set }
    func updatePermission(permission : Permission)
    func getReporterId(empUuid : String)
    
}


protocol PermissionRouterProtocol: class {
    //Presenter -> Wireframe
    func presentHomeTab(from view: UIViewController, with empUuid  : String)
    static func createPermissionModule(permissionRef: PermissionView)
}
