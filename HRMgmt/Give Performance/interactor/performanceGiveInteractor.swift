//
//  performanceGiveInteractor.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 30/05/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
class PerformanceGiveInteractor  : PerformanceMainInputInteractorProtocol {
    
    func updatePerformance(performance: Performance) {
        updatePerformanceDatabase(performance: performance)
    }
    
    private func updatePerformanceDatabase(performance : Performance){
        db.updatePerformance(performance: performance)
        print(performance.getComments())
    }
    
   
    
    
}
