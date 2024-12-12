//
//  CreateQueryPresenter.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 18/06/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
import UIKit
class CreateQueryPresenter : CreateQueryPresenterProtocol {
    var interactor: CreateQueryInputInteractorProtocol?
    
    var view: CreateQueryViewProtocol?
    
    var router: CreateQueryRouterProtocol?
    
    func getQueryIncharge() {
        interactor?.getQueryIncharge()
    }
    
    func updateQuery(query: Query) {
        interactor?.updateQuery(query: query)
    }
    
    func presentHomeTab(from view: UIViewController, with empUuid: String) {
        router?.presentHomeTab(from: view, with: empUuid)
    }
    
    
}
extension CreateQueryPresenter : CreateQueryOutputInteractorProtocol{
    func setQueryIncharge(queryIncharge: [queryIncharge]) {
        view?.setQueryIncharge(queryIncharge: queryIncharge)
    }
    
    
}
