//
//  PaySlipInteractor.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 31/05/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
class PaySlipInteractor : PaySlipInputInteractorProtocol {
    var presenter: PaySlipOutputInteractorProtocol?
    
    func getPaySlip(empUuid: String) {
        let paySlip = getPaySlipDetails(empUuid: empUuid)
        presenter?.updatedPaySlip(paySlip: paySlip)
    }
    
    private func getPaySlipDetails(empUuid : String) -> PaySlip {
        let paySlip = PaySlip(empUuid: empUuid, basicSalary: 10000, homeRentAllowance: 100, conveyanceAllowance: 200, medicalAllowance: 300, travelAllowance: 400, profidentFund: 500, insuranceAmount: 600, professionalTax: 700)
        return paySlip
    }
    
}
