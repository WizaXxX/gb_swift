//
//  main.swift
//  lesson-3.4-json.decoder
//
//  Created by Илья Козырев on 19.07.2022.
//

import Foundation

guard let data = Helper.getJsonData().data(using: .utf8) else { exit(1) }

do {
    let resultModel = try JSONDecoder().decode(WeatherDescription.self, from: data)
    print(resultModel)
} catch {
    print(error)
}
