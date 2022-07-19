//
//  TempData.swift
//  lesson-3.4-json.decoder
//
//  Created by Илья Козырев on 19.07.2022.
//

import Foundation

struct TempData: Decodable {
    let day: Double
    let min: Double?
    let max: Double?
    let night: Double?
    let eve: Double?
    let morn: Double?
    
    enum CodingKeys: String, CodingKey {
        case day, min, max, night, eve, morn
    }
}

extension TempData {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
                
        let dayData = try container.decode(Double.self, forKey: .day)
        if let celDayData = Helper.fromFahrToCelsius(dayData) {
            day = celDayData
        } else {
            day = 0
        }
        
        let minData = try container.decodeIfPresent(Double.self, forKey: .min)
        min = Helper.fromFahrToCelsius(minData)
        
        let maxData = try container.decodeIfPresent(Double.self, forKey: .max)
        max = Helper.fromFahrToCelsius(maxData)
        
        let nightData = try container.decodeIfPresent(Double.self, forKey: .night)
        night = Helper.fromFahrToCelsius(nightData)
        
        let eveData = try container.decodeIfPresent(Double.self, forKey: .eve)
        eve = Helper.fromFahrToCelsius(eveData)
        
        let mornData = try container.decodeIfPresent(Double.self, forKey: .morn)
        morn = Helper.fromFahrToCelsius(mornData)
    }
}
