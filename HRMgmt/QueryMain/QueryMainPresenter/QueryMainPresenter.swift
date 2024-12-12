//
//  QueryMainPresenter.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 18/06/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
import UIKit
class QueryMainPresenter : QueryMainPresenterProtocol {
    var interactor: QueryMainInputInteractorProtocol?
    
    var view: QueryMainViewProtocol?
    
    var router: QueryMainRouterProtocol?
    
    func checkQueryIncharge(empUuid: String) {
        interactor?.checkQueryIncharge(empUuid: empUuid)
    }
    
    func getYourQueries(empUuid: String) {
        interactor?.getYourQueries(empUuid: empUuid)
    }
    
    func getRespondingQueries(empUuid: String) {
        interactor?.getRespondingQueries(empUuid: empUuid)
    }
    
    func presentSingleQuery(from view: UIViewController, with empUuid: String, with query: Query) {
        router?.presentSingleQuery(from: view, with: empUuid, with: query)
    }
    
    
}
extension QueryMainPresenter : QueryMainOutputInteractorProtocol {
    func isQueryIncharge(queryIncharge: Bool) {
        view?.isQueryIncharge(queryIncharge: queryIncharge)
    }
    
    func updatedYourQueries(queries: [Query]) {
        view?.updatedYourQueries(queries: queries)
    }
    
    func updatedRespondQueries(queries: [Query]) {
        view?.updatedRespondQueries(queries: queries)
    }
    
    
}
