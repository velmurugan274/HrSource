//
//  SingleQueryInteractor.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 19/06/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
class SingleQueryInteractor : SingleQueryInputInteractorProtocol{
    var presenter: SingleQueryOutputInteractorProtocol?
    
    func getQuerySenderName(empUuid: String) {
        let name = db.getEmpName(empUuid: empUuid)
        presenter?.setQuerySenderName(name: name)
    }
    
    func getQueryReplies(queryUuid: String) {
        let queryReplies = db.getQueryReplies(queryUuid: queryUuid)
        presenter?.setQueryReplies(replies: queryReplies)
    }
    
    func updateQueryReply(queryReply: QueryReplies) {
        db.updateQueryReplies(queryReplies: queryReply)
    }
    
    
}
