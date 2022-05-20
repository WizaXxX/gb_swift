//
//  Car.swift
//  task
//
//  Created by WizaXxX on 26.04.2022.
//

import Foundation

// не очень понял почему не работает без AnyObject,
// точнее я понимаю что дело как то связанно с тем, что классы
// передаются по ссылке. Нагуглил такое решение проблемы.
// Хотелось бы понять этот момент. Если я не ставил AnyObject,
// тогда все методы нужно было помечать как mutating, и тогда при релаизации классов
// SportCar и TrunkCar в месте вызова doDefaultAction происходила ошибка
// компилятора cannot use mutating member on immutable value:'self' is immutable
protocol Car: AnyObject {
    var brand: String { get }
    var creationYear: Int { get }
    var trunkMaxVolume: Int { get }
    var trunkVolume: Int { get set }
    var isEngineWork: Bool { get set }
    var isWindowsOpen: Bool { get set }
    
    func doAction(action: Actions)
}

extension Car {
        
    func doDefaultAction(action: Actions) {
        switch action {
        case .startEngine:
            startEngine()
        case .stopEngine:
            stopEngine()
        case .openWindows:
            self.isWindowsOpen = true
        case .closeWindows:
            isWindowsOpen = false
        case .getFromTrunk(let volume):
            getFromTrunk(volume: volume)
        case .setToTrunk(let volume):
            setToTrunk(volume: volume)
        default:
            actionCantUse(action: action)
        }
    }
    
    private func startEngine() {
        self.isEngineWork = true
    }
    
    private func stopEngine() {
        self.isEngineWork = true
    }
    
    private func openWindows() {
        self.isWindowsOpen = true
    }
    
    private func closeWindows() {
        self.isWindowsOpen = false
    }
    
    private func getFromTrunk(volume: Int) {
        let newValue: Int = trunkVolume - volume
        if newValue < 0 {
            print("В багажнике нет столько. Всего в багажнике осталось \(trunkVolume)")
            return
        }
        self.trunkVolume -= volume
    }
    
    private func setToTrunk(volume: Int) {
        let newValue: Int = trunkVolume + volume
        if newValue > trunkMaxVolume {
            print("В багажник столько не влезет. Свободно: \(trunkMaxVolume - trunkVolume)")
            return
        }
        self.trunkVolume += volume
    }
    
    private func actionCantUse(action: Actions) {
        print("Действие \(action) не поддерживается.")
    }
    
}
