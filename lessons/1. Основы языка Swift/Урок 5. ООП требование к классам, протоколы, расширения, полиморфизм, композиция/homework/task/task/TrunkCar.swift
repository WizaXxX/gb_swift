//
//  TrunkCar.swift
//  task
//
//  Created by WizaXxX on 26.04.2022.
//

import Foundation

class TrunkCar: Car {
    let brand: String
    let creationYear: Int
    let trunkMaxVolume: Int
    var trunkVolume: Int = 0
    var isEngineWork: Bool = false
    var isWindowsOpen: Bool = false
    
    var withTrailer: Bool = false
    let weelsCount: Int
    
    init(brand: String, creationYear: Int, trunkMaxVolume: Int, weelsCount: Int) {
        self.brand = brand
        self.creationYear = creationYear
        self.trunkMaxVolume = trunkMaxVolume
        self.weelsCount = weelsCount
    }
    
    func doAction(action: Actions) {
        switch action {
        case .setTrailer:
            withTrailer = true
        case .disableTrailer:
            withTrailer = false
        default:
            doDefaultAction(action: action)
        }
    }

}

extension TrunkCar: CustomStringConvertible {
    var description: String {
        return "Бренд: \(brand); Год выпуска: \(creationYear); Грузоподъемность: \(trunkMaxVolume) кг; В багажнике: \(trunkVolume) кг; Двигатель запущен: \(isEngineWork) ; Окна открыты: \(isWindowsOpen); Прицеп подключен: \(withTrailer); Количество колес: \(weelsCount);"
    }
}
