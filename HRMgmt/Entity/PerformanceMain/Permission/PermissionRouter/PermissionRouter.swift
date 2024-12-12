//
//  PermissionRouter.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 30/05/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
import UIKit
class PermissionRouter : PermissionRouterProtocol {
    func presentHomeTab(from view : UIViewController, with empUuid : String) {
        print("yes3")
        let vc = TabBarController()
        vc.empUuid = empUuid
        view.navigationController?.present(vc, animated: true, completion: nil)
    }
    
    
    
    class func createPermissionModule(permissionRef: PermissionView) {
        let presenter : PermissionOutputInteractorProtocol & PermissionPresenterProtocol = PermissionPresenter()
        permissionRef.presenter = presenter
        permissionRef.presenter?.interactor = PermissionInteractor()
        permissionRef.presenter?.view = permissionRef
        permissionRef.presenter?.router = PermissionRouter()
        permissionRef.presenter?.interactor?.presenter = presenter
        
    }
    
}
