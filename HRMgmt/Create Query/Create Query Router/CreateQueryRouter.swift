//
//  CreateQueryRouter.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 18/06/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
import UIKit
class CreateQueryRouter : CreateQueryRouterProtocol {
    func presentHomeTab(from view: UIViewController, with empUuid: String) {
        view.navigationController?.dismiss(animated: true, completion: nil)
        
    }
    
    static func createCreateQueryModule(createQueryRef: CreateQuery) {
        let presenter : CreateQueryOutputInteractorProtocol & CreateQueryPresenterProtocol = CreateQueryPresenter()
        createQueryRef.presenter = presenter
        createQueryRef.presenter?.interactor = CreateQueryInteractor()
        createQueryRef.presenter?.view = createQueryRef
        createQueryRef.presenter?.router = CreateQueryRouter()
        createQueryRef.presenter?.interactor?.presenter = presenter
        
    }
    
    
}
