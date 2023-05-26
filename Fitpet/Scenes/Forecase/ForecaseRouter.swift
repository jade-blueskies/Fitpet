//
//  ForecaseRouter.swift
//  Fitpet
//
//  Created by 박지성 on 2023/05/26.
//

import UIKit

protocol ForecaseRoutingLogic {
    func routeToSomewhere()
}

protocol ForecaseDataPassing {
    var dataStore: ForecaseDataStore? { get }
}

class ForecaseRouter: NSObject, ForecaseRoutingLogic, ForecaseDataPassing {
    
    weak var viewController: ForecaseViewController?
    var dataStore: ForecaseDataStore?
    
    
    
    // MARK: Routing
    
    func routeToSomewhere() {
        
    }
    
}
