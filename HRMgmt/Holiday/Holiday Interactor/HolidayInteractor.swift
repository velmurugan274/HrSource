//
//  HolidayInteractor.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 07/06/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
class HolidayInteractor : HolidayInputInteractorProtocol {
    var presenter: HolidayOutputInteractorProtocol?
    
    func getLeaveDates(year: Int) {
        var holidays = [Holiday]()
        let yearStart = ((year-1970)*31536000+(((year-1970-1)/4)*86400))-19800
        let yearEnd = yearStart + (365*86400)
        holidays = fetchLeaveDates(startDate: yearStart, endDate: yearEnd)
        presenter?.updatedLeaveDate(leaveDates: holidays)
    }
    
    private func fetchLeaveDates(startDate : Int, endDate: Int) -> [Holiday]{
        return db.fetchLeaveDates(startDate: startDate, endDate: endDate)
    }
    
    
}
