//
//  ForecastInteractor.swift
//  Fitpet
//
//  Created by 박지성 on 2023/05/26.
//

import Foundation
import RxSwift

protocol ForecastBusinessLogic {
    func requestDailyForecasts(request: Forecast.DailyForecasts.Request)
    func requestNextDailyForecasts(request: Forecast.DailyForecasts.Request)
}

protocol ForecastDataStore {
}

class ForecastInteractor: ForecastBusinessLogic, ForecastDataStore {
    
    var presenter: ForecastPresentationLogic?
    
    private let forecastService = ForecastService()
    private var disposeBag = DisposeBag()
    
    private let locations: [(cityName: String, countryCode: String, timeZoneAbbreviation: String)] = [
        (cityName: "seoul", countryCode: "KR", timeZoneAbbreviation: "KST"),
        (cityName: "london", countryCode: "GB", timeZoneAbbreviation: "BST"),
        (cityName: "chicago", countryCode: "US", timeZoneAbbreviation: "CST")
    ]
    private var pageNum = 0
    private var hasNextPage: Bool {
        return self.pageNum < self.locations.count - 1
    }
    
    
    func requestDailyForecasts(request: Forecast.DailyForecasts.Request) {
        let pageNum = 0
        let location = self.locations[pageNum]
        
        self.disposeBag = .init()
        self.forecastService.requestDailyForecastOf(
            cityName: location.cityName,
            countryCode: location.countryCode,
            timeZone: TimeZone(abbreviation: location.timeZoneAbbreviation)!)
            .observe(on: MainScheduler.instance)
            .subscribe(
                onSuccess: { [weak self] dailyForecast in
                    guard let `self` = self else { return }
                    self.pageNum = pageNum
                    self.presenter?.presentDailyForecasts(response: .init(
                        forecasts: [dailyForecast],
                        hasNext: self.hasNextPage
                    ))
                },
                onFailure: { [weak self] error in
                    self?.presenter?.presentDailyForecastsLoadingFailure(error: error)
                })
            .disposed(by: self.disposeBag)
    }
    
    func requestNextDailyForecasts(request: Forecast.DailyForecasts.Request) {
        let pageNum = self.pageNum + 1
        guard pageNum < self.locations.count else { return }
        let location = self.locations[pageNum]
        
        self.disposeBag = .init()
        self.forecastService.requestDailyForecastOf(
            cityName: location.cityName,
            countryCode: location.countryCode,
            timeZone: TimeZone(abbreviation: location.timeZoneAbbreviation)!)
            .observe(on: MainScheduler.instance)
            .subscribe(
                onSuccess: { [weak self] dailyForecast in
                    guard let `self` = self else { return }
                    self.pageNum = pageNum
                    self.presenter?.presentNextDailyForecasts(response: .init(
                        forecasts: [dailyForecast],
                        hasNext: self.hasNextPage
                    ))
                },
                onFailure: { [weak self] error in
                    self?.presenter?.presentNextDailyForecastsLoadingFailure(error: error)
                })
            .disposed(by: self.disposeBag)
    }
    
}
