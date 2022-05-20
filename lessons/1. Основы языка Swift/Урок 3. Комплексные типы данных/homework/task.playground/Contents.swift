import Cocoa

enum Actions {
    case startEngine, stopEngine
    case openWindows, closeWindows
    case getFromTrunk(volume: Int)
    case setToTrunk(volume: Int)
}

struct Car {
    let brand: String
    let creationYear: Int
    let trunkMaxVolume: Int
    var trunkVolume: Int
    var isEngineWork: Bool
    var isWindowsOpen: Bool
    
    mutating func doAction(action: Actions) {
        
        switch action {
        case .startEngine:
            isEngineWork = true
        case .stopEngine:
            isEngineWork = false
        case .openWindows:
            isWindowsOpen = true
        case .closeWindows:
            isWindowsOpen = false
        case .getFromTrunk(let volume):
            let newValue: Int = trunkVolume - volume
            if newValue < 0 {
                print("В багажнике нет столько. Всего в багажнике осталось \(trunkVolume)")
                return
            }
            trunkVolume -= volume
        case .setToTrunk(let volume):
            let newValue: Int = trunkVolume + volume
            if newValue > trunkMaxVolume {
                print("В багажник столько не влезет. Свободно: \(trunkMaxVolume - trunkVolume)")
                return
            }
            trunkVolume += volume
        }
    }
}

struct Van {
    let brand: String
    let creationYear: Int
    let trunkMaxVolume: Int
    var trunkVolume: Int
    var isEngineWork: Bool
    var isWindowsOpen: Bool
    
    mutating func doAction(action: Actions) {
        
        switch action {
        case .startEngine:
            isEngineWork = true
        case .stopEngine:
            isEngineWork = false
        case .openWindows:
            isWindowsOpen = true
        case .closeWindows:
            isWindowsOpen = false
        case .getFromTrunk(let volume):
            getFromTruk(volume: volume)
        case .setToTrunk(let volume):
            setToTruck(volume: volume)
        }
    }
    
    private mutating func getFromTruk(volume: Int) {
        let newValue: Int = trunkVolume - volume
        if newValue < 0 {
            print("В кузове нет столько. Всего в багажнике осталось \(trunkVolume)")
            return
        }
        trunkVolume -= volume
    }
    
    private mutating func setToTruck(volume: Int) {
        let newValue: Int = trunkVolume + volume
        if newValue > trunkMaxVolume {
            print("В кузов столько не влезет. Свободно: \(trunkMaxVolume - trunkVolume)")
            return
        }
        trunkVolume += volume
    }
}

var car = Car(brand: "mazda", creationYear: 1990, trunkMaxVolume: 100, trunkVolume: 0, isEngineWork: false, isWindowsOpen: false)
var van = Van(brand: "Kamaz", creationYear: 2000, trunkMaxVolume: 1000, trunkVolume: 0, isEngineWork: false, isWindowsOpen: false)

car.doAction(action: .startEngine)
car.doAction(action: .openWindows)
car.doAction(action: .setToTrunk(volume: 923))
car.doAction(action: .setToTrunk(volume: 50))
car.doAction(action: .getFromTrunk(volume: 999))
print(car)

van.doAction(action: .startEngine)
van.doAction(action: .openWindows)
van.doAction(action: .closeWindows)
van.doAction(action: .setToTrunk(volume: 923))
van.doAction(action: .setToTrunk(volume: 50))
van.doAction(action: .getFromTrunk(volume: 999))
print(van)
