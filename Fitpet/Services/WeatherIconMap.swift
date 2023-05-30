//
//  WeatherIconMap.swift
//  Fitpet
//
//  Created by 박지성 on 2023/05/29.
//

import Foundation

enum WeatherIconMap {
    
    static func iconName(withID id: Int) -> String? {
        switch id {
        case 200: return "wi-thunderstorm"
        case 201: return "wi-thunderstorm"
        case 202: return "wi-thunderstorm"
        case 210: return "wi-lightning"
        case 211: return "wi-lightning"
        case 212: return "wi-lightning"
        case 221: return "wi-lightning"
        case 230: return "wi-thunderstorm"
        case 231: return "wi-thunderstorm"
        case 232: return "wi-thunderstorm"
        case 300: return "wi-sprinkle"
        case 301: return "wi-sprinkle"
        case 302: return "wi-rain"
        case 310: return "wi-rain-mix"
        case 311: return "wi-rain"
        case 312: return "wi-rain"
        case 313: return "wi-showers"
        case 314: return "wi-rain"
        case 321: return "wi-sprinkle"
        case 500: return "wi-sprinkle"
        case 501: return "wi-rain"
        case 502: return "wi-rain"
        case 503: return "wi-rain"
        case 504: return "wi-rain"
        case 511: return "wi-rain-mix"
        case 520: return "wi-showers"
        case 521: return "wi-showers"
        case 522: return "wi-showers"
        case 531: return "wi-storm-showers"
        case 600: return "wi-snow"
        case 601: return "wi-snow"
        case 602: return "wi-sleet"
        case 611: return "wi-rain-mix"
        case 612: return "wi-rain-mix"
        case 615: return "wi-rain-mix"
        case 616: return "wi-rain-mix"
        case 620: return "wi-rain-mix"
        case 621: return "wi-snow"
        case 622: return "wi-snow"
        case 701: return "wi-showers"
        case 711: return "wi-smoke"
        case 721: return "wi-day-haze"
        case 731: return "wi-dust"
        case 741: return "wi-fog"
        case 761: return "wi-dust"
        case 762: return "wi-dust"
        case 771: return "wi-cloudy-gusts"
        case 781: return "wi-tornado"
        case 800: return "wi-day-sunny"
        case 801: return "wi-cloudy-gusts"
        case 802: return "wi-cloudy-gusts"
        case 803: return "wi-cloudy-gusts"
        case 804: return "wi-cloudy"
        case 900: return "wi-tornado"
        case 901: return "wi-storm-showers"
        case 902: return "wi-hurricane"
        case 903: return "wi-snowflake-cold"
        case 904: return "wi-hot"
        case 905: return "wi-windy"
        case 906: return "wi-hail"
        case 957: return "wi-strong-wind"
        default:
            return nil
        }
    }
    
}
