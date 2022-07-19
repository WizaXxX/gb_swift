//
//  Weather.swift
//  lesson-3.4-json.decoder
//
//  Created by Илья Козырев on 19.07.2022.
//

import Foundation

struct WeatherDescription: Decodable {
    let lat: Double
    let lon: Double
    let timeZone: String
    let timeZoneOffset: Int
    let current: WeatherData
    let minutely: [WeatherData]
    let hourly: [WeatherData]
    let daily: [WeatherData]
    let alerts: [Alert]
    
    enum CodingKeys: String, CodingKey {
        case lat, lon
        case timeZone = "timezone"
        case timeZoneOffset = "timezone_offset"
        case current, minutely, hourly, daily, alerts
    }
}
