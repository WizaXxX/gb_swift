//
//  main.swift
//  task
//
//  Created by WizaXxX on 26.04.2022.
//

import Foundation

enum Actions {
    case startEngine, stopEngine
    case openWindows, closeWindows
    case getFromTrunk(volume: Int)
    case setToTrunk(volume: Int)
    case activateAfterburner
    case setTrailer, disableTrailer
}

let car1 = SportCar(brand: "honda", creationYear: 1990, trunkMaxVolume: 100, afterburnerAvailable: false)
car1.doAction(action: .activateAfterburner)
print(car1)

let car2 = SportCar(brand: "lada", creationYear: 1900, trunkMaxVolume: 100, afterburnerAvailable: true)
car2.doAction(action: .activateAfterburner)
car2.doAction(action: .setTrailer)
car2.doAction(action: .setToTrunk(volume: 99))
print(car2)

let car3 = TrunkCar(brand: "Volvo", creationYear: 2022, trunkMaxVolume: 3000, weelsCount: 16)
car3.doAction(action: .setTrailer)
print(car3)
