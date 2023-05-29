//
//  OWMOneCallDto.swift
//  Fitpet
//
//  Created by 박지성 on 2023/05/29.
//

import Foundation

struct OWMOneCallDto: Codable {
    let lat: Double
    let lon: Double
    let timezone: String
    let timezoneOffset: Int
    let daily: [Daily]

    enum CodingKeys: String, CodingKey {
        case lat
        case lon
        case timezone
        case timezoneOffset = "timezone_offset"
        case daily
    }
    
    // MARK: - Daily
    struct Daily: Codable {
        let dt: Int
        let sunrise: Int
        let sunset: Int
        let moonrise: Int
        let moonset: Int
        let moonPhase: Double
        let temp: Temp
        let feelsLike: FeelsLike
        let pressure: Int
        let humidity: Int
        let dewPoint: Double
        let windSpeed: Double
        let windDeg: Int
        let windGust: Double
        let weather: [Weather]
        let clouds: Int
        let pop: Double
        let uvi: Double
        let rain: Double?

        enum CodingKeys: String, CodingKey {
            case dt
            case sunrise
            case sunset
            case moonrise
            case moonset
            case moonPhase = "moon_phase"
            case temp
            case feelsLike = "feels_like"
            case pressure
            case humidity
            case dewPoint = "dew_point"
            case windSpeed = "wind_speed"
            case windDeg = "wind_deg"
            case windGust = "wind_gust"
            case weather
            case clouds
            case pop
            case uvi
            case rain
        }
        
        // MARK: - FeelsLike
        struct FeelsLike: Codable {
            let day: Double
            let night: Double
            let eve: Double
            let morn: Double

            enum CodingKeys: String, CodingKey {
                case day
                case night
                case eve
                case morn
            }
        }

        // MARK: - Temp
        struct Temp: Codable {
            let day: Double
            let min: Double
            let max: Double
            let night: Double
            let eve: Double
            let morn: Double

            enum CodingKeys: String, CodingKey {
                case day
                case min
                case max
                case night
                case eve
                case morn
            }
        }

        // MARK: - Weather
        struct Weather: Codable {
            let id: Int
            let main: String
            let description: String
            let icon: String

            enum CodingKeys: String, CodingKey {
                case id
                case main
                case description
                case icon
            }
        }

    }
}
