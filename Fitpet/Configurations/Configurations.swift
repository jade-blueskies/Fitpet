//
//  Configurations.swift
//  Fitpet
//
//  Created by 박지성 on 2023/05/29.
//

import Foundation

enum Configurations {
    
    static var openWeatherMapAPIKey: String {
        self.dic["OpenWeatherMapAPIKey"] as! String
    }
    
}

extension Configurations {
    
    private static var dic: [String : Any] {
        Bundle.main.infoDictionary?["Configurations"] as! [String : Any]
    }
    
}
