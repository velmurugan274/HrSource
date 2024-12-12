

import Foundation
import  UIKit
protocol PerformanceMainViewProtocol  {
    // PRESENTER -> VIEW
    var presenter : PerformanceMainPresenterProtocol? { get set }

    
}


protocol PerformanceMainPresenterProtocol {
    //View -> Presenter
    var  interactor: PerformanceMainInputInteractorProtocol? { get set }
    var view:  PerformanceMainViewProtocol?  { get set }
    var router: PerformanceMainRouterProtocol? { get set }
    
    func updatePerformance(performance : Performance)
    
   // func presentHomeTab(from view : UIViewController)
    
}



protocol PerformanceMainInputInteractorProtocol {
    
    //Presenter -> Interactor
    func updatePerformance(performance : Performance)

    
}


protocol PerformanceMainRouterProtocol: class {
    //Presenter -> Wireframe
  //  func presentHomeTab(from view: UIViewController)
    static func createPerformanceMainModule(performanceMainRef: PerformanceMainView)
}
