//
//  LoginProtocol.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 29/05/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
import  UIKit



protocol TabBarPresenterProtocol {
    //View -> Presenter
    
    func presentHomeTab(from view : UIViewController)
    
}

protocol TabBarRouterProtocol: class {
    //Presenter -> Wireframe
    func presentHomeTab(from view: UIViewController)
    static func createLoginModule(loginRef: LoginView)
}
