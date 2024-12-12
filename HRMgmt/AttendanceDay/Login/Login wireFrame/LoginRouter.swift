//
//  LoginRouter.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 29/05/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
import UIKit
class LoginRouter : LoginRouterProtocol{
    func presentHomeTab(from view : UIViewController, with empUuid : String) {
        print("yes3")
        let vc = TabBarController()
        vc.empUuid = empUuid
        view.navigationController?.present(vc, animated: true, completion: nil)
        print("Yespd")
    }
    
    class func createLoginModule(loginRef: LoginView) {
        let presenter : LoginOutputInteractorProtocol & LoginPresenterProtocol = LoginPresenter()
        loginRef.presenter = presenter
        loginRef.presenter?.interactor = LoginInteractor()
        loginRef.presenter?.view = loginRef
        loginRef.presenter?.router = LoginRouter()
        loginRef.presenter?.interactor?.presenter = presenter

    }
    
    
}
