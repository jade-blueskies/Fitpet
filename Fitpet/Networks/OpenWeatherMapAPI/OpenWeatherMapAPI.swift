//
//  OpenWeatherMapAPI.swift
//  Fitpet
//
//  Created by 박지성 on 2023/05/26.
//

import Foundation
import Alamofire
import RxSwift

final class OpenWeatherMapAPI {
    static var apiKey: String?
    
    
    func requestCoordinatesBy(cityName: String, countryCode: String, limit: Int) -> Single<[OWMCoordinatesDto]> {
        return .create { observer in
            guard let apiKey = Self.apiKey else {
                fatalError("OpenWeatherMapAPI.apiKey is not initialized")
            }
            let urlString = "http://api.openweathermap.org/geo/1.0/direct?q=\(cityName),\(countryCode)&limit=\(limit)&appid=\(apiKey)"
            
            guard let url = URL(string: urlString) else {
                fatalError("\(#fileID), \(#function) wrong url: \(urlString)")
            }
            
            let request = AF.request(url)
            request.responseDecodable { (response: DataResponse<[OWMCoordinatesDto], AFError>) in
                switch response.result {
                case .success(let dto):
                    observer(.success(dto))
                case .failure(let error):
                    observer(.failure(error))
                }
            }
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    
    func requestOneCall(lat: Double, lon: Double) -> Single<OWMOneCallDto> {
        return .create { observer in
            guard let apiKey = Self.apiKey else {
                fatalError("OpenWeatherMapAPI.apiKey is not initialized")
            }
            let urlString = "https://api.openweathermap.org/data/3.0/onecall?lat=\(lat)&lon=\(lon)&exclude=current,minutely,hourly,alerts&appid=\(apiKey)"
            
            guard let url = URL(string: urlString) else {
                fatalError("\(#fileID), \(#function) wrong url: \(urlString)")
            }
            
            let request = AF.request(url)
            request.responseDecodable { (response: DataResponse<OWMOneCallDto, AFError>) in
                switch response.result {
                case .success(let dto):
                    observer(.success(dto))
                case .failure(let error):
                    observer(.failure(error))
                }
            }
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
}
