//
//  performanceGivePresenter.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 30/05/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
class PerformanceGivePresenter : PerformanceMainPresenterProtocol{
    var interactor: PerformanceMainInputInteractorProtocol?
    
    var view: PerformanceMainViewProtocol?
    
    var router: PerformanceMainRouterProtocol?
    
    func updatePerformance(performance: Performance) {
        interactor?.updatePerformance(performance: performance)
    }
    
    
}
