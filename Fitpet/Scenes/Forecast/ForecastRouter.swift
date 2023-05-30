//
//  ForecastRouter.swift
//  Fitpet
//
//  Created by 박지성 on 2023/05/26.
//

import UIKit

protocol ForecastRoutingLogic {
    func routeToSomewhere()
}

protocol ForecastDataPassing {
    var dataStore: ForecastDataStore? { get }
}

class ForecastRouter: NSObject, ForecastRoutingLogic, ForecastDataPassing {
    
    weak var viewController: ForecastViewController?
    var dataStore: ForecastDataStore?
    
    
    
    // MARK: Routing
    
    func routeToSomewhere() {
        
    }
    
}
