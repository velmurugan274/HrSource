//
//  SingleTaskRouter.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 17/06/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
class SingleTaskRouter : SingleTaskRouterProtocol{
    static func createSingleTaskModule(singleTaskRef: SingleTaskView) {
        let presenter : SingleTaskOutputInteractorProtocol & SingleTaskPresenterProtocol = SingleTaskPresenter()
        singleTaskRef.presenter = presenter
        singleTaskRef.presenter?.interactor = SingleTaskInteractor()
        singleTaskRef.presenter?.view = singleTaskRef
        singleTaskRef.presenter?.router = SingleTaskRouter()
        singleTaskRef.presenter?.interactor?.presenter = presenter
    }
    
    
}
