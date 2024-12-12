
import Foundation
import  UIKit
protocol CreateTaskViewProtocol  {
    // PRESENTER -> VIEW
    func setTaskOwners(taskOwners : [TaskOwners])
    
}


protocol CreateTaskPresenterProtocol {
    //View -> Presenter
    var  interactor: CreateTaskInputInteractorProtocol? { get set }
    var view:  CreateTaskViewProtocol?  { get set }
    var router: CreateTaskRouterProtocol? { get set }
    
    func getTaskOwner(empUuid : String)
    func updateTask(task : Task)
    
    func presentHomeTab(from view : UIViewController, with empUuid  : String)
    
}

protocol CreateTaskOutputInteractorProtocol {
    //Interactor -> Presenter
    func setTaskOwners(taskOwners : [TaskOwners])
    
}

protocol CreateTaskInputInteractorProtocol {
    
    //Presenter -> Interactor
    var presenter: CreateTaskOutputInteractorProtocol? { get set }
    func updateTask(task : Task)
    func getTaskOwner(empUuid : String)
    
}


protocol CreateTaskRouterProtocol: class {
    //Presenter -> Wireframe
    func presentHomeTab(from view: UIViewController, with empUuid  : String)
    static func createCreateTaskModule(createTaskRef: CreateTask)
}
