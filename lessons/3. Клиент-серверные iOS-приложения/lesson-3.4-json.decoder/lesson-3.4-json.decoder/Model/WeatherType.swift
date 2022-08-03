//
//  WeatherType.swift
//  lesson-3.4-json.decoder
//
//  Created by Илья Козырев on 19.07.2022.
//

import Foundation

struct WeatherType: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}
