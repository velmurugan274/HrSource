//
//  HomeRouter.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 29/05/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
import UIKit
class HomeRouter: HomeRouterProtocol {
   
    
    func showNotification(from view: UIViewController, with empUuid: String) {
        let notification = NotificationView()
        notification.empUuid = empUuid
        view.navigationController?.pushViewController(notification, animated: false)
    }
    
    func showProfile(from view: UIViewController, with empUuid: String) {
        let profile = ProfileView()
        profile.empUuid = empUuid
        profile.selectUuid = empUuid
        view.navigationController?.pushViewController(profile, animated: true)
    }
   
    func presentHomeModules(from view: UIViewController, with indexPath: Int, with empUuid: String) {
        if(indexPath == 0) {
            let attendanceWeek = Attendance()
            attendanceWeek.empUuid = empUuid
            view.navigationController?.pushViewController( attendanceWeek, animated: true)
        }
        else if(indexPath == 1){
            let leaveTracker = LeaveTracker()
            leaveTracker.empUuid = empUuid
            view.navigationController?.pushViewController( leaveTracker , animated: true)
        }
        else if(indexPath == 2){
            let permission = PermissionView()
            permission.empUuid = empUuid
            view.navigationController?.pushViewController( permission , animated: true)
        }
        else if(indexPath == 3){
            view.navigationController?.pushViewController( HolidayView() , animated: true)
        }
    }
    
    static func createHomeModule(homeRef: HomeView) {
        let presenter : HomeOutputInteractorProtocol & HomePresenterProtocol = HomePresenter()
        homeRef.presenter = presenter
        homeRef.presenter?.interactor = HomeInteractor()
        homeRef.presenter?.view = homeRef
        homeRef.presenter?.router = HomeRouter()
        homeRef.presenter?.interactor?.presenter = presenter
    }
    
}
