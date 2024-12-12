//
//  HolidayPresenter.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 07/06/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
class HolidayPresenter : HolidayPresenterProtocol {
    var interactor: HolidayInputInteractorProtocol?
    
    var view: HolidayViewProtocol?
    
    var router: HolidayRouterProtocol?
    
    func getLeaveDates(year: Int) {
        interactor?.getLeaveDates(year: year)
    }
    
}
extension HolidayPresenter : HolidayOutputInteractorProtocol {
    func updatedLeaveDate(leaveDates: [Holiday]) {
        view?.updatedLeaveDate(leaveDates: leaveDates)
    }
    
    
}
