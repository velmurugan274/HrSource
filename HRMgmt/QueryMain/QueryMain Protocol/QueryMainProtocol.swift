


import Foundation
import  UIKit
protocol QueryMainViewProtocol  {
    // PRESENTER -> VIEW
    func isQueryIncharge(queryIncharge : Bool)
    func updatedYourQueries(queries : [Query])
    func updatedRespondQueries(queries : [Query])
}


protocol QueryMainPresenterProtocol {
    //View -> Presenter
    var  interactor: QueryMainInputInteractorProtocol? { get set }
    var view:  QueryMainViewProtocol?  { get set }
    var router: QueryMainRouterProtocol? { get set }
    
    func checkQueryIncharge(empUuid : String)
    func getYourQueries(empUuid : String)
    func getRespondingQueries(empUuid : String)
    func presentSingleQuery(from view : UIViewController, with empUuid : String, with query : Query)
    
}

protocol QueryMainOutputInteractorProtocol {
    //Interactor -> Presenter
    func isQueryIncharge(queryIncharge : Bool)
    func updatedYourQueries(queries : [Query])
    func updatedRespondQueries(queries : [Query])
    
}

protocol QueryMainInputInteractorProtocol {
    
    //Presenter -> Interactor
    var presenter: QueryMainOutputInteractorProtocol? { get set }
    func checkQueryIncharge(empUuid : String)
    func getYourQueries(empUuid : String)
    func getRespondingQueries(empUuid : String)
    
}


protocol QueryMainRouterProtocol: class {
    //Presenter -> Wireframe
    func presentSingleQuery(from view : UIViewController, with empUuid : String, with query : Query)
    static func createQueryMainModule(queryMainRef : QueryMainView)
}
