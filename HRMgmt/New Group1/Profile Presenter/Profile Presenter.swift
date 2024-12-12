//
//  Profile Presenter.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 31/05/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
import UIKit
class ProfilePresenter : ProfilePresenterProtocol {
    func showProfile(from view: UIViewController, with empUuid: String, with selectUuid: String) {
        router?.showProfile(from: view, with: empUuid, with: selectUuid)
    }
    
    func getReporterDetails(empUuid: String) {
        interactor?.getReporterDetails(empUuid: empUuid)
    }
    
    func getDirectReportingDetails(empUuid: String) {
        interactor?.getDirectReportingDetails(empUuid: empUuid)
    }
    
    var interactor: ProfileInputInteractorProtocol?
    
    var view: ProfileViewProtocol?
    
    var router: ProfileRouterProtocol?
    
    func getProfileDetails(empUuid: String) {
        interactor?.getProfileDetails(empUuid: empUuid)
    }
    
    
}
extension ProfilePresenter : ProfileOutputInteractorProtocol {
    func updatedDirectReportingDetails(reporterDetails: [People]) {
        view?.updatedDirectReportingDetails(reporterDetails: reporterDetails)
    }
    
    func updatedReporterDetails(reporterDetails: People) {
        view?.updatedReporterDetails(reporterDetails: reporterDetails)
    }
    
    func updatedProfileDetails(profileDetails: Profile) {
        view?.updatedProfileDetails(profileDetails: profileDetails)
    }
    
    
    
    
}
