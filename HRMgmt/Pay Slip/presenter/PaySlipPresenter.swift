//
//  PaySlipPresenter.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 31/05/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
class PaySlipPresenter : PaySlipPresenterProtocol {
    var interactor: PaySlipInputInteractorProtocol?
    
    var view: PaySlipViewProtocol?
    
    var router: PaySlipRouterProtocol?
    
    func getPaySlip(empUuid: String) {
        interactor?.getPaySlip(empUuid: empUuid)
    }
    
    
}

extension PaySlipPresenter : PaySlipOutputInteractorProtocol {
    func updatedPaySlip(paySlip: PaySlip) {
        view?.UpdatedPaySlip(paySlip: paySlip)
    }
    
    
}
