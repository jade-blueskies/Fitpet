//
//  ForecastModels.swift
//  Fitpet
//
//  Created by 박지성 on 2023/05/26.
//

import UIKit

enum Forecast {
    
    enum DailyForecasts {
        struct Request {
            
        }
        struct Response {
            var forecasts: [DailyForecastModel]
            var hasNext: Bool
        }
        struct ViewModel {
            var listModel: [Section]
            var hasNext: Bool
            
            struct Section {
                var locationName: String
                var rows: [Row]
            }
            struct Row {
                var date: String
                var weatherIconName: String?
                var weatherDescription: String
                var minimumTemperature: Int
                var maximumTemperature: Int
            }
        }
    }
    
}
