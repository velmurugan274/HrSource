//
//  HolidayRouter.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 07/06/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

import Foundation
class HolidayRouter : HolidayRouterProtocol {
    static func createHolidayModule(holidayRef: HolidayView) {
        let presenter :  HolidayOutputInteractorProtocol &  HolidayPresenterProtocol =  HolidayPresenter()
         holidayRef.presenter = presenter
         holidayRef.presenter?.interactor =  HolidayInteractor()
         holidayRef.presenter?.view =  holidayRef
         holidayRef.presenter?.router =  HolidayRouter()
         holidayRef.presenter?.interactor?.presenter = presenter
    }
    
    
}
