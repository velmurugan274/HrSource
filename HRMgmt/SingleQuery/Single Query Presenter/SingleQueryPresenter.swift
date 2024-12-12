//
//  SingleViewPresenter.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 19/06/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
class SingleQueryPresenter : SingleQueryPresenterProtocol {
    var interactor: SingleQueryInputInteractorProtocol?
    
    var view: SingleQueryViewProtocol?
    
    var router: SingleQueryRouterProtocol?
    
    func getQuerySenderName(empUuid: String) {
        interactor?.getQuerySenderName(empUuid: empUuid)
    }
    
    func getQueryReplies(queryUuid: String) {
        interactor?.getQueryReplies(queryUuid: queryUuid)
        
    }
    
    func updateQueryReply(queryReply: QueryReplies) {
        interactor?.updateQueryReply(queryReply: queryReply)
    }
    
    
}
extension SingleQueryPresenter : SingleQueryOutputInteractorProtocol {
    func setQuerySenderName(name: String) {
        view?.setQuerySenderName(name: name)
    }
    
    func setQueryReplies(replies: [QueryReplies]) {
        view?.setQueryReplies(replies: replies)
    }
    
    
}
