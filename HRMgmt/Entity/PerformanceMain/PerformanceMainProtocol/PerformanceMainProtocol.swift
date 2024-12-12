//
//  PerformanceProtocol.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 29/05/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
import  UIKit
protocol PerformanceViewProtocol  {
    // PRESENTER -> VIEW
    var presenter : PerformancePresenterProtocol? {get set}
    func updatedPerformanceDetails(PerformanceDetails : Performance)
    func updatedDirectReportingDetails(reporterDetails : [People])
    
}


protocol PerformancePresenterProtocol {
    //View -> Presenter
    var  interactor: PerformanceInputInteractorProtocol? { get set }
    var view:  PerformanceViewProtocol?  { get set }
    var router: PerformanceRouterProtocol? { get set }
    
    func getPerformanceDetails(empUuid : String)

    func getDirectReportingDetails(empUuid : String)
    
    func showGivePerformance(from view: UIViewController, with empUuid : String, with selectUuid : String)
    
    
}

protocol PerformanceOutputInteractorProtocol {
    //Interactor -> Presenter
    func updatedPerformanceDetails(PerformanceDetails : Performance)
    func updatedDirectReportingDetails(reporterDetails : [People])
    
}

protocol PerformanceInputInteractorProtocol {
    
    //Presenter -> Interactor
    var presenter: PerformanceOutputInteractorProtocol? { get set }
    func getPerformanceDetails(empUuid : String)
    func getDirectReportingDetails(empUuid : String)
    
}


protocol PerformanceRouterProtocol: class {
    //Presenter -> Wireframe
    //   func presentHomeTab(from view: UIViewController, with empUuid : String)
    
    func showPerformance(from view: UIViewController, with empUuid : String, with selectUuid : String)
    static func createPerformanceModule(perfRef: PerformanceMain)
}


