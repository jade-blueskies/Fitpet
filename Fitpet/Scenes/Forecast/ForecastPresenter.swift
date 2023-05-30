//
//  ForecastPresenter.swift
//  Fitpet
//
//  Created by 박지성 on 2023/05/26.
//

import Foundation

protocol ForecastPresentationLogic {
    func presentDailyForecasts(response: Forecast.DailyForecasts.Response)
    func presentDailyForecastsLoadingFailure(error: Error)
    func presentNextDailyForecasts(response: Forecast.DailyForecasts.Response)
    func presentNextDailyForecastsLoadingFailure(error: Error)
}

class ForecastPresenter: ForecastPresentationLogic {
    
    weak var viewController: ForecastDisplayLogic?
    
    typealias Section = Forecast.DailyForecasts.ViewModel.Section
    typealias Row = Forecast.DailyForecasts.ViewModel.Row
    
    
    
    func presentDailyForecasts(response: Forecast.DailyForecasts.Response) {
        let forecasts = response.forecasts
        let hasNext = response.hasNext
             
        let listModel = self.converToListModel(from: forecasts)
        self.viewController?.displayDailyForecasts(viewModel: .init(
            listModel: listModel,
            hasNext: hasNext
        ))
    }
    
    func presentDailyForecastsLoadingFailure(error: Error) {
        self.viewController?.displayDailyForecastsLoadingFailure()
    }
    
    
    
    func presentNextDailyForecasts(response: Forecast.DailyForecasts.Response) {
        let forecasts = response.forecasts
        let hasNext = response.hasNext
        
        let listModel = self.converToListModel(from: forecasts)
        self.viewController?.displayNextDailyForecasts(viewModel: .init(
            listModel: listModel,
            hasNext: hasNext
        ))
    }
    
    func presentNextDailyForecastsLoadingFailure(error: Error) {
        self.viewController?.displayNextDailyForecastsLoadingFailure()
    }
    
    
    
    private func converToListModel(from forecasts: [DailyForecastModel]) -> [Section] {
        return forecasts.map { (model) in
            var calendar = Calendar.current
            calendar.timeZone = model.timeZone
            
            let formatter = DateFormatter()
            formatter.timeZone = model.timeZone
            formatter.dateFormat = "EEE d MMM"
            
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
    }
    
}
