//
//  ForecastPresenter.swift
//  Fitpet
//
//  Created by 박지성 on 2023/05/26.
//

import Foundation

protocol ForecastPresentationLogic {
    func presentDailyForecasts(response: Forecast.DailyForecasts.Response)
}

class ForecastPresenter: ForecastPresentationLogic {
    
    weak var viewController: ForecastDisplayLogic?
    
    
    func presentDailyForecasts(response: Forecast.DailyForecasts.Response) {
        switch response.result {
        case .success(let dailyForecastModels):
            typealias Section = Forecast.DailyForecasts.ViewModel.Section
            typealias Row = Forecast.DailyForecasts.ViewModel.Row
            
            let listModel = dailyForecastModels.map { (model) in
                var calendar = Calendar.current
                calendar.timeZone = model.timeZone
                
                let formatter = DateFormatter()
                formatter.timeZone = model.timeZone
                formatter.dateFormat = "EEE dd MMM"
                
                return Section(
                    locationName: model.locationName.uppercased(),
                    rows: model.forecasts.map { (forecast) in
                        return Row(
                            date: {
                                let date = forecast.date
                                if calendar.isDateInToday(date) {
                                    return "Today"
                                }
                                if calendar.isDateInTomorrow(date) {
                                    return "Tomorrow"
                                }
                                return formatter.string(from: date)
                            }(),
                            weatherIconName: WeatherIconMap.iconName(withID: forecast.weatherIconID),
                            weatherDescription: forecast.weatherDescription,
                            minimumTemperature: Int(round(forecast.minimumTemperature)),
                            maximumTemperature: Int(round(forecast.maximumTemperature)))
                    })
            }
            self.viewController?.displayDailyForecasts(viewModel: .init(listModel: listModel))
            
        case .failure:
            self.viewController?.displayDailyForecastsLoadingFailure(viewModel: .init(listModel: []))
        }
    }
    
}
