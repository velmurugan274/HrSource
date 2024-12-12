//
//  PerformanceMainInteractor.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 10/06/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
class performanceMainInteractor : PerformanceInputInteractorProtocol {
   
    var presenter: PerformanceOutputInteractorProtocol?
    
    func getDirectReportingDetails(empUuid: String) {
        let directReporters = db.getDirectReporters(empUuid: empUuid)
        presenter?.updatedDirectReportingDetails(reporterDetails: directReporters)
    }
    
    
    func getPerformanceDetails(empUuid: String) {
        let performance = fetchPerformanceDetails(empUuid: empUuid)
        presenter?.updatedPerformanceDetails(PerformanceDetails: performance)
    }
    
    private func fetchPerformanceDetails(empUuid : String) -> Performance {
        let performance = db.getPerformance(empUuid: empUuid)
        return performance
    }
    
}
