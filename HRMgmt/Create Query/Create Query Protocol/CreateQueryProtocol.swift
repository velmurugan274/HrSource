

import Foundation
import  UIKit
protocol CreateQueryViewProtocol  {
    // PRESENTER -> VIEW
    func setQueryIncharge(queryIncharge : [queryIncharge])
    
}


protocol CreateQueryPresenterProtocol {
    //View -> Presenter
    var  interactor: CreateQueryInputInteractorProtocol? { get set }
    var view:  CreateQueryViewProtocol?  { get set }
    var router: CreateQueryRouterProtocol? { get set }
    
    func getQueryIncharge()
    func updateQuery(query : Query)
    
    func presentHomeTab(from view : UIViewController, with empUuid  : String)
    
}

protocol CreateQueryOutputInteractorProtocol {
    //Interactor -> Presenter
    func setQueryIncharge(queryIncharge : [queryIncharge])
    
}

protocol CreateQueryInputInteractorProtocol {
    
    //Presenter -> Interactor
    var presenter: CreateQueryOutputInteractorProtocol? { get set }
    func updateQuery(query : Query)
    func getQueryIncharge()
    
}


protocol CreateQueryRouterProtocol: class {
    //Presenter -> Wireframe
    func presentHomeTab(from view: UIViewController, with empUuid  : String)
    static func createCreateQueryModule(createQueryRef: CreateQuery)
}

class queryIncharge {
    var queryType : String
    var empUuid : String
    init(queryType : String, empUuid : String) {
        self.queryType = queryType
        self.empUuid = empUuid
    }
}
