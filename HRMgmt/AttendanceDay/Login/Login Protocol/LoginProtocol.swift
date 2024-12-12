//
//  LoginProtocol.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 29/05/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
import  UIKit
protocol LoginViewProtocol  {
    // PRESENTER -> VIEW
    func validatedUserID(checkUserID: Bool)
    func validatedPassword(checkPassword: Bool)
    func updatedEmpUuid(empUuid : String)
}


protocol LoginPresenterProtocol {
    //View -> Presenter
    var  interactor: LoginInputInteractorProtocol? { get set }
    var view:  LoginViewProtocol?  { get set }
    var router: LoginRouterProtocol? { get set }
    
    func validateUserID(userID: String)
    func validatePassword(password: String)
    func getEmpUuid(usedId : String)
    
    func presentHomeTab(from view : UIViewController, with empUuid : String)
    
}

protocol LoginOutputInteractorProtocol {
    //Interactor -> Presenter
    func validatedUserID(checkUserID: Bool)
    func validatedPassword(checkPassword: Bool)
    func updatedEmpUuid(empUuid : String)
    
}

protocol LoginInputInteractorProtocol {
    
     //Presenter -> Interactor
    var presenter: LoginOutputInteractorProtocol? { get set }
    func validateUserID(userID: String)
    func getEmpUuid(usedId : String)
    
}


protocol LoginRouterProtocol: class {
    //Presenter -> Wireframe
    func presentHomeTab(from view: UIViewController, with empUuid : String)
    static func createLoginModule(loginRef: LoginView)
}
