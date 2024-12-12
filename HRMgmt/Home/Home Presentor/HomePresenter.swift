//
//  HomePresenter.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 29/05/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
import UIKit
class HomePresenter : HomePresenterProtocol {
    func checkNotification(empUuid: String) {
        interactor?.checkNotification(empUuid: empUuid)
    }
    
    func showNotification(from view: UIViewController, with empUuid: String) {
        router?.showNotification(from: view, with: empUuid)
    }
    
    
    
    
    var interactor: HomeInputInteractorProtocol?
    
    var view: HomeViewProtocol?
    
    var router: HomeRouterProtocol?
    
    func getActiveHours(empUuid: String) {
        interactor?.getActiveHours(empUuid: empUuid)
    }
    
    func updateCurrentStatus(empUuid: String) {
        interactor?.updateStatus(empUuid: empUuid)
    }
    
    func presentHomeModules(from view: UIViewController, with indexPath: Int, with empUuid: String) {
        router?.presentHomeModules(from: view, with: indexPath, with: empUuid)
    }
    
  
    
    func showProfile(from view: UIViewController, with empUuid: String) {
        router?.showProfile(from: view, with: empUuid)
    }
    
    func getCurrentStatus(empUuid: String) {
        interactor?.getCurrentStatus(empUuid: empUuid)
    }
    
    
    
    
    
}

extension HomePresenter : HomeOutputInteractorProtocol {
    func updatedNotifStatus(notifCheck: Bool) {
        view?.updatedNotifStatus(notifCheck: notifCheck)
    }
    
    func currentStatus(status: String) {
        view?.currentStatus(status: status)
        print(status)
    }
    
    func updatedActiveHours(activeHours: String) {
        view?.UpdatedActiveHours(activeHours: activeHours)
    }
    
    
}
