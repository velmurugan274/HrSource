//
//  InsuranceProtocol.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 03/06/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
import  UIKit
protocol InsuranceViewProtocol  {
    // PRESENTER -> VIEW
    var presenter : InsurancePresenterProtocol? {get set}
    func updatedInsuranceDetails(InsuranceDetails : Insurance)
}


protocol InsurancePresenterProtocol {
    //View -> Presenter
    var  interactor: InsuranceInputInteractorProtocol? { get set }
    var view:  InsuranceViewProtocol?  { get set }
    var router: InsuranceRouterProtocol? { get set }
    
    func getInsuranceDetails(empUuid : String)
    func updatedInsuranceDetails(InsuranceDetails : Insurance)
}

protocol InsuranceOutputInteractorProtocol {
    //Interactor -> Presenter
    func updatedInsuranceDetails(InsuranceDetails : Insurance)
    
}

protocol InsuranceInputInteractorProtocol {
    
    //Presenter -> Interactor
    var presenter: InsuranceOutputInteractorProtocol? { get set }
    func getInsuranceDetails(empUuid : String)
    
}


protocol InsuranceRouterProtocol: class {
    //Presenter -> Wireframe
    //   func presentHomeTab(from view: UIViewController, with empUuid : String)
    static func createInsuranceModule(insuranceRef: InsuranceView)
}

enum InsuranceType : String {
    case goldPremium = "GOLD Premium"
    case platinumPremium = "PLATINUM Premium"
    case silverPremium = "SILVER Premium"
    
}
class Insurance {
    var empUuid : String
    var insuranceNumber : String
    var insuranceType : InsuranceType
    var insurancePremiumAmount : Int
    var insuranceDetails : String
    init(empUuid : String, insuranceNumber : String, insuranceType : InsuranceType, insurancePremiumAmount : Int, insuranceDetails : String) {
        self.empUuid = empUuid
        self.insuranceNumber = insuranceNumber
        self.insuranceType = insuranceType
        self.insurancePremiumAmount = insurancePremiumAmount
        self.insuranceDetails = insuranceDetails
    }
}
