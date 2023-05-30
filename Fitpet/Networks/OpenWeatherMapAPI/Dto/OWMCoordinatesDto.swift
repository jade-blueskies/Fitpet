//
//  OWMCoordinatesDto.swift
//  Fitpet
//
//  Created by 박지성 on 2023/05/26.
//

import Foundation

struct OWMCoordinatesDto: Codable {
    let name: String
    let localNames: [String: String]
    let lat: Double
    let lon: Double
    let country: String

    enum CodingKeys: String, CodingKey {
        case name
        case localNames = "local_names"
        case lat
        case lon
        case country
    }
}
