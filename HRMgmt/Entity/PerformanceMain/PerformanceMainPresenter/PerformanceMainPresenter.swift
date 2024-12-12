//
//  PerformanceMainPresenter.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 10/06/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
import  UIKit
class PerformanceMainPresenter : PerformancePresenterProtocol{
    
    
    var interactor: PerformanceInputInteractorProtocol?
    
    var view: PerformanceViewProtocol?
    
    var router: PerformanceRouterProtocol?
    
    func getPerformanceDetails(empUuid: String) {
        interactor?.getPerformanceDetails(empUuid: empUuid)
    }
    
 
    
    func getDirectReportingDetails(empUuid: String) {
        interactor?.getDirectReportingDetails(empUuid: empUuid)
    }
    
    func showGivePerformance(from view: UIViewController, with empUuid: String, with selectUuid: String) {
        router?.showPerformance(from: view, with: empUuid, with: selectUuid)
    }
    
    
    
    
}
extension PerformanceMainPresenter : PerformanceOutputInteractorProtocol{
    func updatedPerformanceDetails(PerformanceDetails: Performance) {
        view?.updatedPerformanceDetails(PerformanceDetails: PerformanceDetails)
    }
    
    func updatedDirectReportingDetails(reporterDetails: [People]) {
        view?.updatedDirectReportingDetails(reporterDetails: reporterDetails)
    }
    
    
    
}
