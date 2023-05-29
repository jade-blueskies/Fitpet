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
        case 200: return "thunderstorm"
        case 201: return "thunderstorm"
        case 202: return "thunderstorm"
        case 210: return "lightning"
        case 211: return "lightning"
        case 212: return "lightning"
        case 221: return "lightning"
        case 230: return "thunderstorm"
        case 231: return "thunderstorm"
        case 232: return "thunderstorm"
        case 300: return "sprinkle"
        case 301: return "sprinkle"
        case 302: return "rain"
        case 310: return "rain-mix"
        case 311: return "rain"
        case 312: return "rain"
        case 313: return "showers"
        case 314: return "rain"
        case 321: return "sprinkle"
        case 500: return "sprinkle"
        case 501: return "rain"
        case 502: return "rain"
        case 503: return "rain"
        case 504: return "rain"
        case 511: return "rain-mix"
        case 520: return "showers"
        case 521: return "showers"
        case 522: return "showers"
        case 531: return "storm-showers"
        case 600: return "snow"
        case 601: return "snow"
        case 602: return "sleet"
        case 611: return "rain-mix"
        case 612: return "rain-mix"
        case 615: return "rain-mix"
        case 616: return "rain-mix"
        case 620: return "rain-mix"
        case 621: return "snow"
        case 622: return "snow"
        case 701: return "showers"
        case 711: return "smoke"
        case 721: return "day-haze"
        case 731: return "dust"
        case 741: return "fog"
        case 761: return "dust"
        case 762: return "dust"
        case 771: return "cloudy-gusts"
        case 781: return "tornado"
        case 800: return "day-sunny"
        case 801: return "cloudy-gusts"
        case 802: return "cloudy-gusts"
        case 803: return "cloudy-gusts"
        case 804: return "cloudy"
        case 900: return "tornado"
        case 901: return "storm-showers"
        case 902: return "hurricane"
        case 903: return "snowflake-cold"
        case 904: return "hot"
        case 905: return "windy"
        case 906: return "hail"
        case 957: return "strong-wind"
        default:
            return nil
        }
    }
    
}
