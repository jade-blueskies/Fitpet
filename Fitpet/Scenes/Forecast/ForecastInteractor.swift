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
}

protocol ForecastDataStore {
}

class ForecastInteractor: ForecastBusinessLogic, ForecastDataStore {
    
    var presenter: ForecastPresentationLogic?
    
    let forecastService = ForecastService()
    private let disposeBag = DisposeBag()
    
    private let locations: [(cityName: String, countryCode: String, timeZoneAbbreviation: String)] = [
        (cityName: "seoul", countryCode: "KR", timeZoneAbbreviation: "KST"),
        (cityName: "london", countryCode: "GB", timeZoneAbbreviation: "BST"),
        (cityName: "chicago", countryCode: "US", timeZoneAbbreviation: "CST")
    ]
    
    
    func requestDailyForecasts(request: Forecast.DailyForecasts.Request) {
        let singles = self.locations
            .map { location in
                self.forecastService.requestDailyForecastOf(
                    cityName: location.cityName,
                    countryCode: location.countryCode,
                    timeZone: TimeZone(abbreviation: location.timeZoneAbbreviation)!)
            }
        Single.zip(singles)
            .observe(on: MainScheduler.instance)
            .subscribe(
                onSuccess: { [weak self] dailyForecasts in
                    self?.presenter?.presentDailyForecasts(response: .init(result: .success(dailyForecasts)))
                },
                onFailure: { [weak self] error in
                    self?.presenter?.presentDailyForecasts(response: .init(result: .failure(error)))
                })
            .disposed(by: self.disposeBag)
    }
    
}
