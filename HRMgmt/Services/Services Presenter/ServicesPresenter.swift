//
//  ServicesPresenter.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 10/06/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
import UIKit
class ServicesPresenter : ServicesPresenterProtocol {
    var router: ServicesRouterProtocol?
    
    func presentServicesModules(from view: UIViewController, with indexPath: Int, with empUuid: String) {
        router?.presentServicesModules(from: view, with: indexPath, with: empUuid)
        print("yes")
    }
    

    
}
