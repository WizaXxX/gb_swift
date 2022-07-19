//
//  CurrentWeather.swift
//  lesson-3.4-json.decoder
//
//  Created by Илья Козырев on 19.07.2022.
//

import Foundation

enum DataError: Error {
    case DontHaveCurrectlyDayTempData
    case DontHaveCurrectlyFeelsLikeTempData
}

struct WeatherData: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        date = try container.decode(Date.self, forKey: .date)
        sunrise = try container.decodeIfPresent(Date.self, forKey: .sunrise)
        sunset = try container.decodeIfPresent(Date.self, forKey: .sunset)
        moonrise = try container.decodeIfPresent(Date.self, forKey: .moonrise)
        moonset = try container.decodeIfPresent(Date.self, forKey: .moonset)
        moonPhase = try container.decodeIfPresent(Double.self, forKey: .moonPhase)
        
        if let tempData = try? container.decodeIfPresent(Double.self, forKey: .temp) {
            guard let dayData = Helper.fromFahrToCelsius(tempData) else { throw DataError.DontHaveCurrectlyDayTempData }
            temp = TempData(
                day: dayData,
                min: nil,
                max: nil,
                night: nil,
                eve: nil,
                morn: nil)
        } else {
            temp = try container.decodeIfPresent(TempData.self, forKey: .temp)
        }
        
        if let tempData = try? container.decodeIfPresent(Double.self, forKey: .feelsLike) {
            guard let dayData = Helper.fromFahrToCelsius(tempData) else { throw DataError.DontHaveCurrectlyFeelsLikeTempData }
            feelsLike = TempData(
                day: dayData,
                min: nil,
                max: nil,
                night: nil,
                eve: nil,
                morn: nil)
        } else {
            feelsLike = try container.decodeIfPresent(TempData.self, forKey: .feelsLike)
        }
        
        pressure = try container.decodeIfPresent(Int.self, forKey: .pressure)
        humidity = try container.decodeIfPresent(Int.self, forKey: .humidity)
        dewPoint = try container.decodeIfPresent(Double.self, forKey: .dewPoint)
        uvi = try container.decodeIfPresent(Double.self, forKey: .uvi)
        clouds = try container.decodeIfPresent(Int.self, forKey: .clouds)
        visibility = try container.decodeIfPresent(Int.self, forKey: .visibility)
        windSpeed = try container.decodeIfPresent(Double.self, forKey: .windSpeed)
        windDeg = try container.decodeIfPresent(Int.self, forKey: .windDeg)
        windGust = try container.decodeIfPresent(Double.self, forKey: .windGust)
        weather = try container.decodeIfPresent([WeatherType].self, forKey: .weather)
        
        if let rainData = try? container.decodeIfPresent(RainData.self, forKey: .rain) {
            rain = rainData.oneHour
        } else {
            rain = try container.decodeIfPresent(Double.self, forKey: .rain)
        }
        
        precipitation = try container.decodeIfPresent(Double.self, forKey: .precipitation)
        pop = try container.decodeIfPresent(Double.self, forKey: .pop)
        
    }
    
    let date: Date
    let sunrise: Date?
    let sunset: Date?
    let moonrise: Date?
    let moonset: Date?
    let moonPhase: Double?
    let temp: TempData?
    let feelsLike: TempData?
    let pressure: Int?
    let humidity: Int?
    let dewPoint: Double?
    let uvi: Double?
    let clouds: Int?
    let visibility: Int?
    let windSpeed: Double?
    let windDeg: Int?
    let windGust: Double?
    let weather: [WeatherType]?
    let rain: Double?
    let precipitation: Double?
    let pop: Double?
    
    enum CodingKeys: String, CodingKey {
        case date = "dt"
        case sunrise, sunset, temp, moonrise, moonset
        case moonPhase = "moon_phase"
        case feelsLike = "feels_like"
        case pressure, humidity
        case dewPoint = "dew_point"
        case uvi, clouds, visibility
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case windGust = "wind_gust"
        case weather, rain, precipitation
        case pop
    }
}
