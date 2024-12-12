import Foundation
import  UIKit
protocol SingleQueryViewProtocol  {
    // PRESENTER -> VIEW
    func setQuerySenderName(name : String)
    func setQueryReplies(replies : [QueryReplies])
}


protocol SingleQueryPresenterProtocol {
    //View -> Presenter
    var  interactor: SingleQueryInputInteractorProtocol? { get set }
    var view:  SingleQueryViewProtocol?  { get set }
    var router: SingleQueryRouterProtocol? { get set }
    
    func getQuerySenderName(empUuid : String)
    func getQueryReplies(queryUuid : String)
    func updateQueryReply(queryReply : QueryReplies)
    
    
}

protocol SingleQueryOutputInteractorProtocol {
    //Interactor -> Presenter
    func setQuerySenderName(name : String)
    func setQueryReplies(replies : [QueryReplies])
    
}

protocol SingleQueryInputInteractorProtocol {
    
    //Presenter -> Interactor
    var presenter: SingleQueryOutputInteractorProtocol? { get set }
    func getQuerySenderName(empUuid : String)
    func getQueryReplies(queryUuid : String)
    func updateQueryReply(queryReply : QueryReplies)
    
}


protocol SingleQueryRouterProtocol: class {
    //Presenter -> Wireframe
    static func createSingleQueryModule(singleQueryRef: SingleQueryView)
}
