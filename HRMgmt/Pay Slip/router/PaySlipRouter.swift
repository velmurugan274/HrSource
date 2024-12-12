//
//  PaySlipRouter.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 31/05/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
class PaySlipRouter : PaySlipRouterProtocol {
    
    
    static func createPaySlipModule(paySlipRef: PaySlipView) {
        let presenter : PaySlipOutputInteractorProtocol & PaySlipPresenterProtocol = PaySlipPresenter()
        paySlipRef.presenter = presenter
        paySlipRef.presenter?.interactor = PaySlipInteractor()
        paySlipRef.presenter?.view = paySlipRef
        paySlipRef.presenter?.router = PaySlipRouter()
        paySlipRef.presenter?.interactor?.presenter = presenter
    }
    
    
}
