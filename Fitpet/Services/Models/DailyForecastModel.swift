//
//  DailyForecastModel.swift
//  Fitpet
//
//  Created by 박지성 on 2023/05/29.
//

import Foundation

struct DailyForecastModel {
    
    var locationName: String
    var timeZone: TimeZone
    var forecasts: [ForecastModel]
    
}
