//
//  Profile Interactor.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 31/05/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
import UIKit
class ProfileInteractor : ProfileInputInteractorProtocol {
    func getReporterDetails(empUuid: String) {
        let reporter = db.getReporterDetail(empUuid: empUuid)
        presenter?.updatedReporterDetails(reporterDetails: reporter)
    }
    
    
    func getDirectReportingDetails(empUuid: String) {
        let directReporters = db.getDirectReporters(empUuid: empUuid)
        presenter?.updatedDirectReportingDetails(reporterDetails: directReporters)
    }
    
    var presenter: ProfileOutputInteractorProtocol?
    let db = DatabaseController()
    
    func getProfileDetails(empUuid: String) {
        let profile = fetchProfileDetails(empUuid: empUuid)
        presenter?.updatedProfileDetails(profileDetails: profile)
    }
    
    private func fetchProfileDetails(empUuid : String) -> Profile {
        let profile = db.getProfileDetails(empUuid: empUuid)
        return profile
    }
    
    
    
}
