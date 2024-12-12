//
//  AttendanceDayRouter.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 12/06/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
class AttendanceDayRouter : AttendanceDayRouterProtocol {
    static func createAttendanceDayModule(attendanceDayRef: AttendanceDayView) {
        let presenter : AttendanceDayOutputInteractorProtocol & AttendanceDayPresenterProtocol = AttendanceDayPresenter()
        attendanceDayRef.presenter = presenter
        attendanceDayRef.presenter?.interactor = AttendanceDayInteractor()
        attendanceDayRef.presenter?.view = attendanceDayRef
        attendanceDayRef.presenter?.router = AttendanceDayRouter()
        attendanceDayRef.presenter?.interactor?.presenter = presenter
    }
    
    
}
