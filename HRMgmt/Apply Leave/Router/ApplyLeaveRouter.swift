//
//  ApplyLeaveRouter.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 30/05/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
import UIKit
class ApplyLeaveRouter : ApplyLeaveRouterProtocol {
    func presentHomeTab(from view : UIViewController, with empUuid : String) {
        print("yes3")
        view.navigationController?.popViewController(animated: true)
    }
    


    class func createApplyLeaveModule(applyLeaveRef: ApplyLeaveView) {
            let presenter : ApplyLeaveOutputInteractorProtocol & ApplyLeavePresenterProtocol = ApplyLeavePresenter()
            applyLeaveRef.presenter = presenter
            applyLeaveRef.presenter?.interactor = ApplyLeaveInteractor()
            applyLeaveRef.presenter?.view = applyLeaveRef
            applyLeaveRef.presenter?.router = ApplyLeaveRouter()
            applyLeaveRef.presenter?.interactor?.presenter = presenter
            
        }
    
}
