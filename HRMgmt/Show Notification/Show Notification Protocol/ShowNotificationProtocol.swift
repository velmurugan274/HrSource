import Foundation
import  UIKit
protocol ShowNotificationViewProtocol  {
    // PRESENTER -> VIEW
    func likeStatus(liked : Bool)
    
}


protocol ShowNotificationPresenterProtocol {
    //View -> Presenter
    var  interactor:  ShowNotificationInputInteractorProtocol? { get set }
    var view:   ShowNotificationViewProtocol?  { get set }
    var router : ShowNotificationRouterProtocol? { get set }

    
    func isLiked(empUuid :String, notiId :Int)
    func updateStatus(empUuid: String, notifId : Int, likeStatus : Bool)
    
    
    
    
}

protocol ShowNotificationOutputInteractorProtocol {
    //Interactor -> Presenter
    func likeStatus(liked : Bool)
    
    
}

protocol  ShowNotificationInputInteractorProtocol {
    
    //Presenter -> Interactor
    var presenter:  ShowNotificationOutputInteractorProtocol? { get set }
    func isLiked(empUuid : String, notifId : Int)
    func updateStatus(empUuid: String, notifId : Int, likeStatus : Bool)
    
}

protocol  ShowNotificationRouterProtocol: class {
    //Presenter -> Wireframe
   // func  showFullNotification(from view: UIViewController, with notification: Notification, with empUuid: String)
    static func createShowNotificationModule( showNotificationRef: ShowNotification)
}

