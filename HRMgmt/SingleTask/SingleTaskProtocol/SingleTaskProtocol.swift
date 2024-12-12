//
//  SingleTaskProtocol.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 17/06/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
import  UIKit
protocol SingleTaskViewProtocol  {
    // PRESENTER -> VIEW
    func setReporterName(name  : String)

    
}


protocol SingleTaskPresenterProtocol {
    //View -> Presenter
    var  interactor: SingleTaskInputInteractorProtocol? { get set }
    var view:  SingleTaskViewProtocol?  { get set }
    var router: SingleTaskRouterProtocol? { get set }
    
    func markAsCompleted(taskId : String)
    func getReporterName(empUuid : String)
    
    
    
}

protocol SingleTaskOutputInteractorProtocol {
    //Interactor -> Presenter
    func setReporterName(name : String)
    
}

protocol SingleTaskInputInteractorProtocol {
    
    //Presenter -> Interactor
    var presenter: SingleTaskOutputInteractorProtocol? { get set }
    func markAsCompleted(taskId : String)
    func getReporterName(empUuid : String)
    

    
}


protocol SingleTaskRouterProtocol: class {
    //Presenter -> Wireframe

    static func createSingleTaskModule(singleTaskRef: SingleTaskView)
}
