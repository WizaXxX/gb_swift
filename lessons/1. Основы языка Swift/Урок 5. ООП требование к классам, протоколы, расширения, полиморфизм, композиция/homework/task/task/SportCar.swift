//
//  SportCar.swift
//  task
//
//  Created by WizaXxX on 26.04.2022.
//

import Foundation

class SportCar: Car {
    var brand: String
    var creationYear: Int
    var trunkMaxVolume: Int
    var trunkVolume: Int = 0
    var isEngineWork: Bool = false
    var isWindowsOpen: Bool = false
    
    let afterburnerAvailable: Bool
    
    init(brand: String, creationYear: Int, trunkMaxVolume: Int, afterburnerAvailable: Bool) {
        self.brand = brand
        self.creationYear = creationYear
        self.trunkMaxVolume = trunkMaxVolume
        self.afterburnerAvailable = afterburnerAvailable
    }
    
    func doAction(action: Actions) {
        switch action {
        case .activateAfterburner where afterburnerAvailable:
            activateAfterburner()
        case .activateAfterburner where !afterburnerAvailable:
            print("Данная машина не имеет функции форсажа.")
        default:
            doDefaultAction(action: action)
        }
    }
    
    private func activateAfterburner() {
        print("Форсаж активирован!!!")
    }
}

extension SportCar: CustomStringConvertible {
    var description: String {
        return "Бренд: \(brand); Год выпуска: \(creationYear); Грузоподъемность: \(trunkMaxVolume) кг; В багажнике: \(trunkVolume) кг; Двигатель запущен: \(isEngineWork) ; Окна открыты: \(isWindowsOpen); Форсам доступен: \(afterburnerAvailable);"
    }
}
