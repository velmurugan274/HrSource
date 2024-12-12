//
//  ProfileProtocol.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 29/05/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
import  UIKit
protocol ProfileViewProtocol  {
    // PRESENTER -> VIEW
    var presenter : ProfilePresenterProtocol? {get set}
    func updatedProfileDetails(profileDetails : Profile)
    func updatedReporterDetails(reporterDetails : People)
    func updatedDirectReportingDetails(reporterDetails : [People])
    
}


protocol ProfilePresenterProtocol {
    //View -> Presenter
    var  interactor: ProfileInputInteractorProtocol? { get set }
    var view:  ProfileViewProtocol?  { get set }
    var router: ProfileRouterProtocol? { get set }
    
    func getProfileDetails(empUuid : String)
  //  func updatedProfileDetails(profileDetails : Profile)
    
    func getReporterDetails(empUuid : String)
    
    
    func getDirectReportingDetails(empUuid : String)
    
    func showProfile(from view: UIViewController, with empUuid : String, with selectUuid : String)

    
}

protocol ProfileOutputInteractorProtocol {
    //Interactor -> Presenter
    func updatedProfileDetails(profileDetails : Profile)
    func updatedDirectReportingDetails(reporterDetails : [People])
    func updatedReporterDetails(reporterDetails : People)
    
}

protocol ProfileInputInteractorProtocol {
    
    //Presenter -> Interactor
    var presenter: ProfileOutputInteractorProtocol? { get set }
    func getProfileDetails(empUuid : String)
    func getReporterDetails(empUuid : String)
    func getDirectReportingDetails(empUuid : String)
    
}


protocol ProfileRouterProtocol: class {
    //Presenter -> Wireframe
 //   func presentHomeTab(from view: UIViewController, with empUuid : String)
    
    func showProfile(from view: UIViewController, with empUuid : String, with selectUuid : String)
    static func createProfileModule(profileRef: ProfileView)
}

class Profile {
    private var empId : Int
    private var empName : String
    private var telNumber : String
    private var mailId : String
    private var empPosition : String
    private var department : String
    private var location : String
    private var status : Status
    private var reportingId : String
    init(empId : Int, empName : String, telNumber : String,mailId : String , status : Status, department : String , empPosition : String, location : String, reportingId : String){
        self.empId = empId
        self.empName = empName
        self.telNumber = telNumber
        self.mailId = mailId
        self.status = status
        self.department = department
        self.location = location
        self.empPosition = empPosition
        self.reportingId = reportingId
    }
    func getReportingId() -> String{
        return reportingId
    }
    func getEmpId() -> Int{
        return empId
    }
    
    func getEmpName() -> String {
        return empName
    }
    
    func getDetpartmentName() -> String {
        return department
    }
    
    func getTelNumber() -> String {
        return telNumber
    }
    
    func getMailId() -> String {
        return mailId
    }
    
    func getStatus() -> Status {
        return status
    }
    
    func getLocation() -> String {
        return location
    }
    
    func getEmpPosition() -> String {
        return empPosition
    }
    
    
}
