import Foundation
import  UIKit
protocol HomeViewProtocol  {
    // PRESENTER -> VIEW
    func UpdatedActiveHours(activeHours : String)
    func currentStatus(status : String)
    func updatedNotifStatus(notifCheck : Bool)
}


protocol HomePresenterProtocol {
    //View -> Presenter
    var  interactor: HomeInputInteractorProtocol? { get set }
    var view:  HomeViewProtocol?  { get set }
    var router: HomeRouterProtocol? { get set }
    
    func getActiveHours(empUuid: String)
    func updateCurrentStatus(empUuid : String)
    func getCurrentStatus(empUuid : String)
    func presentHomeModules(from view: UIViewController, with indexPath : Int, with empUuid : String)
    func showProfile(from view: UIViewController, with empUuid : String)
    func showNotification(from view : UIViewController,with empUuid : String)
    func checkNotification(empUuid : String)
    
    
}

protocol HomeOutputInteractorProtocol {
    //Interactor -> Presenter
    func updatedActiveHours(activeHours : String)
    func currentStatus(status : String)
    func updatedNotifStatus(notifCheck : Bool)
    
}

protocol HomeInputInteractorProtocol {
    
    //Presenter -> Interactor
    var presenter: HomeOutputInteractorProtocol? { get set }
    func getActiveHours(empUuid : String)
    func updateStatus(empUuid : String)
    func getCurrentStatus(empUuid : String)
    func checkNotification(empUuid :String)
    
}


protocol HomeRouterProtocol: class {
    //Presenter -> Wireframe
    func presentHomeModules(from view: UIViewController, with indexPath : Int, with empUuid : String)
   // func pushNotifications(from view : UIViewController, with empUuid : String)
    func showProfile(from view: UIViewController, with empUuid : String)
    func showNotification(from view : UIViewController,with empUuid : String)
    static func createHomeModule(homeRef: HomeView)
}
