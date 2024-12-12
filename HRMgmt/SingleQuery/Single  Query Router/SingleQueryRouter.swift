//
//  SingleQueryRouter.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 19/06/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
class SingleQueryRouter : SingleQueryRouterProtocol {
    static func createSingleQueryModule(singleQueryRef: SingleQueryView) {
        let presenter : SingleQueryOutputInteractorProtocol & SingleQueryPresenterProtocol = SingleQueryPresenter()
        singleQueryRef.presenter = presenter
        singleQueryRef.presenter?.interactor = SingleQueryInteractor()
        singleQueryRef.presenter?.view = singleQueryRef
        singleQueryRef.presenter?.router = SingleQueryRouter()
        singleQueryRef.presenter?.interactor?.presenter = presenter
    }
    
    
}
