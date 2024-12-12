//
//  LoginInteractor.swift
//  Stock Managemnt
//
//  Created by mahin-pt2331 on 16/05/19.
//  Copyright © 2019 mahin-pt2331. All rights reserved.
//

import Foundation

protocol LoginInputInteractorProtocol {
    
    var presenter: LoginOutputInteractorProtocol? { get set }
    
    func validateUserID(userID: String)
    
}

class LoginInteractor: LoginInputInteractorProtocol {
    
    var presenter: LoginOutputInteractorProtocol?
    
    var check: Bool?
    
    func validateUserID(userID: String) {
        
        check = DatabaseManager.getInstance().isUserID(userID: userID)
        
        presenter?.validatedUserID(checkUserID: check!)
        
    }
    
}
