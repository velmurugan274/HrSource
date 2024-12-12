//
//  PerformanceMainRouter.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 10/06/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
import UIKit
class performanceMainRouter : PerformanceRouterProtocol {
    func showPerformance(from view: UIViewController, with empUuid: String, with selectUuid: String) {
        let performance = PerformanceMainView()
        performance.empUuid = empUuid
        performance.selectUuid = selectUuid
        view.navigationController?.pushViewController( performance , animated: true)
    }
    
    static func createPerformanceModule(perfRef: PerformanceMain) {
        let presenter : PerformanceOutputInteractorProtocol & PerformancePresenterProtocol = PerformanceMainPresenter()
        perfRef.presenter = presenter
        perfRef.presenter?.interactor = performanceMainInteractor()
        perfRef.presenter?.view = perfRef
        perfRef.presenter?.router = performanceMainRouter()
        perfRef.presenter?.interactor?.presenter = presenter
    }
    
    
}
