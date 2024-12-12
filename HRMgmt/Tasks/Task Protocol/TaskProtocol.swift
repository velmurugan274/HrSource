
import Foundation
import  UIKit
protocol TaskViewProtocol  {
    // PRESENTER -> VIEW
    func updatedIncompleteList(incomplete : [Task])
    func updatedCompleteList(complete :[Task])
    
}


protocol TaskPresenterProtocol {
    //View -> Presenter
    var  interactor: TaskInputInteractorProtocol? { get set }
    var view:  TaskViewProtocol?  { get set }
    var router: TaskRouterProtocol? { get set }
    
    func getCompleteList(empUuid : String)
    func getIncompleteList(empUuid : String)
    func presentCreateTask(from view: UIViewController, with empUuid: String)
    func showTask(from view : UIViewController, with task : Task, with buttonHidden : Bool)
    
    
    
}

protocol TaskOutputInteractorProtocol {
    //Interactor -> Presenter
    func updatedIncompleteList(incomplete : [Task])
    func updatedCompleteList(complete :[Task])
    
}

protocol TaskInputInteractorProtocol {
    
    //Presenter -> Interactor
    var presenter: TaskOutputInteractorProtocol? { get set }
    func getCompleteList(empUuid : String)
    func getIncompleteList(empUuid : String)
}


protocol TaskRouterProtocol: class {
    //Presenter -> Wireframe
    func presentCreateTask(from view: UIViewController, with empUuid: String)
    func showTask(from view : UIViewController, with task : Task, with buttonHidden : Bool)
    static func createTaskModule(taskRef: TaskView)
}
