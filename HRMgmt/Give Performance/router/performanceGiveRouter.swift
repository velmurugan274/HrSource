//
//  performance.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 30/05/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
class performanceGiveRouter : PerformanceMainRouterProtocol {
//    func presentHomeTab(from view: UIViewController) {
//        <#code#>
//    }
    
    
    class func createPerformanceMainModule(performanceMainRef: PerformanceMainView) {
        let presenter : PerformanceMainPresenterProtocol = PerformanceGivePresenter()
        performanceMainRef.presenter = presenter
        performanceMainRef.presenter?.interactor = PerformanceGiveInteractor()
        performanceMainRef.presenter?.view = performanceMainRef
        performanceMainRef.presenter?.router = performanceGiveRouter()
        
    }
}
