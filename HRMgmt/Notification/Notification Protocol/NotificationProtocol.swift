
import Foundation
import  UIKit
protocol NotificationViewProtocol  {
    // PRESENTER -> VIEW
    func updatedNotificationList(notification : [Notifications])
    func updatedIndividualNotificationList(notification : [Notifications])
    
}


protocol NotificationPresenterProtocol {
    //View -> Presenter
    var  interactor:  NotificationInputInteractorProtocol? { get set }
    var view:   NotificationViewProtocol?  { get set }
    var router:  NotificationRouterProtocol? { get set }
    
    func getNotificationList(empUuid : String)
    func getIndividualNotificationList(empUuid : String)
    func  showFullNotification(from view: UIViewController, with notification: Notifications, with empUuid: String, with type : Int)
    

    
    
}

protocol NotificationOutputInteractorProtocol {
    //Interactor -> Presenter
    func updatedNotificationList(notification : [Notifications])
    func updatedIndividualNotificationList(notification : [Notifications])
  
}

protocol  NotificationInputInteractorProtocol {
    
    //Presenter -> Interactor
    var presenter:  NotificationOutputInteractorProtocol? { get set }
    func getNotificationList(empUuid : String)
    func getIndividualNotificationList(empUuid : String)

}


protocol  NotificationRouterProtocol: class {
    //Presenter -> Wireframe
    func  showFullNotification(from view: UIViewController, with notification: Notifications, with empUuid: String, with type : Int)
    static func createNotificationModule( notificationRef: NotificationView)
}
