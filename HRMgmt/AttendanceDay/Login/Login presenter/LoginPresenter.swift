//
//  LoginPresenter.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 29/05/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
import  UIKit
class LoginPresenter: LoginPresenterProtocol {
    func presentHomeTab(from view: UIViewController, with empUuid: String) {
        print("yes2")
        router?.presentHomeTab(from : view, with: empUuid)
    }
    
    func getEmpUuid(usedId: String) {
        interactor?.getEmpUuid(usedId: usedId)
    }
    
    func presentHomeTab(from view : UIViewController) {
       
    }
    
    var interactor: LoginInputInteractorProtocol?
    
    var view: LoginViewProtocol?
    
    var router: LoginRouterProtocol?
    
    func validateUserID(userID: String) {
        interactor?.validateUserID(userID: userID)
    }
    
    var checkPassword : Bool?
    
    func validatePassword(password: String) {
        if password == "admin" {
            
            checkPassword = true
            
        } else {
            
            checkPassword = false
            
        }
        
        validatedPassword(checkPassword: checkPassword!)
    }
    

}

extension LoginPresenter : LoginOutputInteractorProtocol {
    func updatedEmpUuid(empUuid: String) {
        view?.updatedEmpUuid(empUuid: empUuid)
    }
    
    func validatedUserID(checkUserID: Bool) {
        view?.validatedUserID(checkUserID: checkUserID)
    }
    
    func validatedPassword(checkPassword: Bool) {
        view?.validatedPassword(checkPassword: checkPassword)
    }
    
    
}
