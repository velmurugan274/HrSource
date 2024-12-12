//
//  HomeRouter.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 29/05/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
import UIKit
class ServicesRouter: ServicesRouterProtocol {
    static func createServicesModule(servicesRef: ServicesView) {
        let presenter :  ServicesPresenterProtocol = ServicesPresenter()
        servicesRef.presenter = presenter
        servicesRef.presenter?.router = ServicesRouter()
    }
    
 
    
    
    
    func presentServicesModules(from view: UIViewController, with indexPath: Int, with empUuid: String) {
        if(indexPath == 0) {
            let taskView = TaskView()
            print("yes")
            taskView.empUuid = empUuid
            view.navigationController?.pushViewController( taskView, animated: true)
        }
        else if(indexPath == 1){
            let performance = PerformanceMain()
            performance.empUuid = empUuid
            view.navigationController?.pushViewController( performance , animated: true)
        }
        else if(indexPath == 2){
            let announcement = MakeAnnouncementView()
            announcement.empUuid = empUuid
            view.navigationController?.pushViewController( announcement , animated: true)
        }
        else if(indexPath == 3){
            let query = QueryMainView()
            query.empUuid = empUuid
            view.navigationController?.pushViewController( query , animated: true)
        }else if indexPath == 4{
            let payRoll = PaySlipView()
            payRoll.empUuid = empUuid
            view.navigationController?.pushViewController(payRoll, animated: true)
        } else if indexPath == 5 {
            let insurance = InsuranceView()
            view.navigationController?.pushViewController(insurance, animated: true)
        } else if indexPath == 6 {
            let files = FilesView()
            view.navigationController?.pushViewController(files, animated: true)
        }else if indexPath == 7 {
            let feed = FeedBack()
            view.navigationController?.pushViewController(feed, animated: true)
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
