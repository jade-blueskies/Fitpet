//
//  ForecastService.swift
//  Fitpet
//
//  Created by 박지성 on 2023/05/29.
//

import Foundation
import RxSwift

final class ForecastService {
    
    private let openWeatherMapAPI = OpenWeatherMapAPI()
    
    func requestDailyForecastOf(cityName: String, countryCode: String, timeZone: TimeZone) -> Single<DailyForecastModel> {
        return self.openWeatherMapAPI
            .requestCoordinatesBy(cityName: cityName, countryCode: countryCode, limit: 1)
            .flatMap { [weak self] dtos -> Single<OWMOneCallDto> in
                guard let `self` = self else { return .never() }
                guard let dto = dtos.first else {
                    return .error(RxError.unknown)
                }
                return self.openWeatherMapAPI.requestOneCall(lat: dto.lat, lon: dto.lon, units: "metric")
            }
            .map { dto -> DailyForecastModel in
                let forecasts = dto.daily.compactMap { dto -> ForecastModel? in
                    guard let weather = dto.weather.first else {
                        return nil
                    }
                    return ForecastModel(
                        date: Date(timeIntervalSince1970: TimeInterval(dto.dt)),
                        weatherIconID: weather.id,
                        weatherDescription: weather.description,
                        minimumTemperature: dto.temp.min,
                        maximumTemperature: dto.temp.max)
                }
                return DailyForecastModel(locationName: cityName, timeZone: timeZone, forecasts: forecasts)
            }
    }
    
}
