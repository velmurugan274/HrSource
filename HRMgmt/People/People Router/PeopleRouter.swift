//
//  PeopleRouter.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 01/06/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
import UIKit
class PeopleRouter : PeopleRouterProtocol {
    
    func showProfile(from view: UIViewController , with empUuid: String, with selectUuid: String) {
        let profile = ProfileView()
        profile.empUuid = empUuid
        profile.selectUuid = selectUuid
        view.navigationController?.pushViewController(profile, animated: true)
    }
    
    static func createPeopleModule( peopleRef: PeopleView) {
        let presenter : PeopleOutputInteractorProtocol & PeoplePresenterProtocol = PeoplePresenter()
        peopleRef.presenter = presenter
        peopleRef.presenter?.interactor = PeopleInteractor()
        peopleRef.presenter?.view = peopleRef
        peopleRef.presenter?.router = PeopleRouter()
        peopleRef.presenter?.interactor?.presenter = presenter

    }
    
    
}
