import Foundation
import  UIKit

protocol ServicesPresenterProtocol {
    //View -> Presenter
    var router: ServicesRouterProtocol? { get set }
    
    func presentServicesModules(from view: UIViewController, with indexPath : Int, with empUuid : String)

    
    
}




protocol ServicesRouterProtocol: class {
    //Presenter -> Wireframe
    func presentServicesModules(from view: UIViewController, with indexPath : Int, with empUuid : String)
    static func createServicesModule(servicesRef: ServicesView)
}
