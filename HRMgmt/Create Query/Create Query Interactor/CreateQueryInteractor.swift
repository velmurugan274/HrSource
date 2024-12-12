//
//  CreateQueryInteractor.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 18/06/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
class CreateQueryInteractor : CreateQueryInputInteractorProtocol{
    func updateQuery(query: Query) {
        db.updateQueries(query: query)
        
    }
    
    var presenter: CreateQueryOutputInteractorProtocol?
    
    
    func getQueryIncharge() {
        let incharges = db.getQueryType()
        presenter?.setQueryIncharge(queryIncharge: incharges)
    }
    
    
}
