import Foundation
import  UIKit
protocol PaySlipViewProtocol  {
    // PRESENTER -> VIEW
    func UpdatedPaySlip(paySlip : PaySlip)
    
    
}


protocol PaySlipPresenterProtocol {
    //View -> Presenter
    var  interactor: PaySlipInputInteractorProtocol? { get set }
    var view:  PaySlipViewProtocol?  { get set }
    var router: PaySlipRouterProtocol? { get set }
    
    func getPaySlip(empUuid: String)
    
    
}

protocol PaySlipOutputInteractorProtocol {
    //Interactor -> Presenter
    func updatedPaySlip(paySlip : PaySlip)
    
}

protocol PaySlipInputInteractorProtocol {
    
    //Presenter -> Interactor
    var presenter: PaySlipOutputInteractorProtocol? { get set }
    func getPaySlip(empUuid: String)
    
}


protocol PaySlipRouterProtocol: class {
    //Presenter -> Wireframe
    static func createPaySlipModule(paySlipRef: PaySlipView)
}
