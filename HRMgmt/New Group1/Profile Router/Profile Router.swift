//
//  Profile Router.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 31/05/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
import UIKit
class ProfileRouter : ProfileRouterProtocol {
    func showProfile(from view: UIViewController , with empUuid: String, with selectUuid: String) {
        let profile = ProfileView()
        profile.empUuid = empUuid
        profile.selectUuid = selectUuid
        view.navigationController?.pushViewController(profile, animated: true)
    }
    
    static func createProfileModule(profileRef: ProfileView) {
        let presenter : ProfileOutputInteractorProtocol & ProfilePresenterProtocol = ProfilePresenter()
        profileRef.presenter = presenter
        profileRef.presenter?.interactor = ProfileInteractor()
        profileRef.presenter?.view = profileRef
        profileRef.presenter?.router = ProfileRouter()
        profileRef.presenter?.interactor?.presenter = presenter

    }
    
    
}
