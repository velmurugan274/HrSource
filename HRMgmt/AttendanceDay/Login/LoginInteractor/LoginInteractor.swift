//
//  LoginInteractor.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 29/05/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
import UIKit
class LoginInteractor: LoginInputInteractorProtocol  {
    func getEmpUuid(usedId: String) {
        let empUuid = getUuid(loginId: usedId)
        presenter?.updatedEmpUuid(empUuid: empUuid)
    }
    
    var presenter: LoginOutputInteractorProtocol?
    
    var check : Bool?
    func validateUserID(userID: String) {
        check = checkPresent(loginId: userID)
        presenter?.validatedUserID(checkUserID: check!)
    }
    
    private func checkPresent(loginId : String) -> Bool{
            let db = DatabaseController()
            return db.loginPresent(loginId: loginId)

    }
    
    private func getUuid(loginId : String) -> String {
        return db.getEmpId(loginId: loginId)
    }
    
    
}

