//
//  ForecaseInteractor.swift
//  Fitpet
//
//  Created by 박지성 on 2023/05/26.
//

import Foundation
import RxSwift

protocol ForecaseBusinessLogic {
    func requestDailyForecasts(request: Forecase.DailyForecasts.Request)
}

protocol ForecaseDataStore {
}

class ForecaseInteractor: ForecaseBusinessLogic, ForecaseDataStore {
    
    var presenter: ForecasePresentationLogic?
    
    let forecastService = ForecastService()
    private let disposeBag = DisposeBag()
    
    private let locations: [(cityName: String, countryCode: String, timeZoneAbbreviation: String)] = [
        (cityName: "seoul", countryCode: "KR", timeZoneAbbreviation: "KST"),
        (cityName: "london", countryCode: "GB", timeZoneAbbreviation: "BST"),
        (cityName: "chicago", countryCode: "US", timeZoneAbbreviation: "CST")
    ]
    
    
    func requestDailyForecasts(request: Forecase.DailyForecasts.Request) {
        let singles = self.locations
            .map { location in
                self.forecastService.requestDailyForecastOf(
                    cityName: location.cityName,
                    countryCode: location.countryCode,
                    timeZone: TimeZone(abbreviation: location.timeZoneAbbreviation)!)
            }
        Single.zip(singles)
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
