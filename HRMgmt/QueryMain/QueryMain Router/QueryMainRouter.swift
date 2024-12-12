//
//  QueryMainRouter.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 18/06/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
import UIKit
class QueryMainRouter : QueryMainRouterProtocol {
    func presentSingleQuery(from view: UIViewController, with empUuid: String, with queries: Query) {
        let query = SingleQueryView()
        query.empUuid = empUuid
        query.query = queries
        view.navigationController?.pushViewController(query, animated: true)
    }
    
    static func createQueryMainModule(queryMainRef: QueryMainView) {
        let presenter : QueryMainOutputInteractorProtocol & QueryMainPresenterProtocol = QueryMainPresenter()
        queryMainRef.presenter = presenter
        queryMainRef.presenter?.interactor = QueryMainInteractor()
        queryMainRef.presenter?.view = queryMainRef
        queryMainRef.presenter?.router = QueryMainRouter()
        queryMainRef.presenter?.interactor?.presenter = presenter
    }
    
    
}
