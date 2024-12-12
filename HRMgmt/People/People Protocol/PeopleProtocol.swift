import Foundation
import  UIKit
protocol PeopleViewProtocol  {
    // PRESENTER -> VIEW
    var presenter : PeoplePresenterProtocol? {get set}
    func updatedList(peopleDetails : [People])
    func updatedDeptUuid(deptUuid : String)
}


protocol PeoplePresenterProtocol {
    //View -> Presenter
    var  interactor: PeopleInputInteractorProtocol? { get set }
    var view:  PeopleViewProtocol?  { get set }
    var router: PeopleRouterProtocol? { get set }
    
    
    func getDeptUuid(empUuid :String)
    func getCompleteList()
    func getDepartmentList(deptUuid : String)
    func getSearchedList(search : String)
    
    func showProfile(from view: UIViewController, with empUuid : String, with selectUuid : String)

    
}

protocol PeopleOutputInteractorProtocol {
    //Interactor -> Presenter
    func updatedList(peopleDetails : [People])
    func updatedDeptUuid(deptUuid : String)
    
}

protocol PeopleInputInteractorProtocol {
    
    //Presenter -> Interactor
    var presenter: PeopleOutputInteractorProtocol? { get set }
    func getCompleteList()
    func getDeptUuid(empUuid :String)
    func getDepartmentList(deptUuid : String)
    func getSearchedList(search : String)
    
}


protocol PeopleRouterProtocol: class {
    //Presenter -> Wireframe
    //   func presentHomeTab(from view: UIViewController, with empUuid : String)
    func showProfile(from view: UIViewController, with empUuid : String, with selectUuid : String)
    static func createPeopleModule(peopleRef: PeopleView)
}

class People {
    var name : String
    var position : String
    var department : String
    var empUuid : String
    init(name : String, position: String, department : String, empUuid : String) {
        self.name = name
        self.position = position
        self.department = department
        self.empUuid = empUuid
    }
}
