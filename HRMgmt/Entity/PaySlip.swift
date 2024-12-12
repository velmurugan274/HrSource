//
//  PaySlip.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 28/05/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
class PaySlip {
    private var empUuid : String
    private var basicSalary : Int
    private var homeRentAllowance : Int
    private var conveyanceAllowance : Int
    private var medicalAllowance : Int
    private var travelAllowance : Int
    private var profidentFund : Int
    private var insuranceAmount : Int
    private var professionalTax : Int
    init(empUuid : String, basicSalary : Int , homeRentAllowance : Int, conveyanceAllowance : Int, medicalAllowance : Int, travelAllowance: Int, profidentFund : Int, insuranceAmount: Int, professionalTax : Int ) {
        self.basicSalary = basicSalary
        self.homeRentAllowance = homeRentAllowance
        self.conveyanceAllowance = conveyanceAllowance
        self.medicalAllowance = medicalAllowance
        self.travelAllowance = travelAllowance
        self.profidentFund = profidentFund
        self.insuranceAmount = insuranceAmount
        self.professionalTax = professionalTax
        self.empUuid = empUuid
    }
    
    func getBasicSalary() -> Int{
        return basicSalary
    }
    func getHomeRentAllowance() -> Int {
        return homeRentAllowance
    }
    func getConveyanceAllowance() -> Int {
        return conveyanceAllowance
    }
    func getMedicalAllowance() -> Int {
        return medicalAllowance
    }
    func getTravelAllowance() -> Int {
        return travelAllowance
    }
    func getProfidentFund() -> Int {
        return profidentFund
    }
    func  getInsuranceAmount() -> Int {
        return insuranceAmount
    }
    func getProfessionalTax() -> Int {
        return professionalTax
    }
    func getEmpUuid() -> String {
        return empUuid
    }
}
