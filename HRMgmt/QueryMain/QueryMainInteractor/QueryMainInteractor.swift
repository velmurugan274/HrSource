//
//  QueryMainInteractor.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 18/06/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
class QueryMainInteractor : QueryMainInputInteractorProtocol {
    var presenter: QueryMainOutputInteractorProtocol?
    
    func checkQueryIncharge(empUuid: String) {
        let check = db.checkIncharge(empUuid: empUuid)
        presenter?.isQueryIncharge(queryIncharge: check)
    }
    
    func getYourQueries(empUuid: String) {
        let queries = db.getYourQueries(empUUid: empUuid)
        presenter?.updatedYourQueries(queries: queries)
    }
    
    func getRespondingQueries(empUuid: String) {
        let queries = db.getQueriesToRespond(empUUid: empUuid)
        presenter?.updatedRespondQueries(queries: queries)
    }
    
    
}
