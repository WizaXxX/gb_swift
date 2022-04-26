import Cocoa

enum Actions {
    case startEngine, stopEngine
    case openWindows, closeWindows
    case getFromTrunk(volume: Int)
    case setToTrunk(volume: Int)
    case activateAfterburner
    case setTrailer, disableTrailer
}

class Car {
    let brand: String
    let creationYear: Int
    let trunkMaxVolume: Int
    var trunkVolume: Int = 0
    var isEngineWork: Bool = false
    var isWindowsOpen: Bool = false
    
    init(brand: String, creationYear: Int, trunkMaxVolume: Int) {
        self.brand = brand
        self.creationYear = creationYear
        self.trunkMaxVolume = trunkMaxVolume
    }
    
    func doAction(action: Actions) {
        
    }
    
    func getFromTrunk(volume: Int) {
        let newValue: Int = trunkVolume - volume
        if newValue < 0 {
            print("В багажнике нет столько. Всего в багажнике осталось \(trunkVolume)")
            return
        }
        trunkVolume -= volume
    }
    
    func setToTrunk(volume: Int) {
        let newValue: Int = trunkVolume + volume
        if newValue > trunkMaxVolume {
            print("В багажник столько не влезет. Свободно: \(trunkMaxVolume - trunkVolume)")
            return
        }
        trunkVolume += volume
    }
    
    func actionCantUse(action: Actions) {
        print("Действие \(action) не поддерживается.")
    }
    
    func getStringDescription() -> String {
        return "Бренд: \(brand); Год выпуска: \(creationYear); Грузоподъемность: \(trunkMaxVolume) кг; В багажнике: \(trunkVolume) кг; Двигатель запущен: \(isEngineWork) ; Окна открыты: \(isWindowsOpen);"
    }
}

class TrunkCar: Car {
    var withTrailer: Bool = false
    let weelsCount: Int
    
    init(brand: String, creationYear: Int, trunkMaxVolume: Int, weelsCount: Int) {
        self.weelsCount = weelsCount
        super.init(brand: brand, creationYear: creationYear, trunkMaxVolume: trunkMaxVolume)
    }
    
    override func doAction(action: Actions) {
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
            super.getFromTrunk(volume: volume)
        case .setToTrunk(let volume):
            super.setToTrunk(volume: volume)
        case .setTrailer:
            withTrailer = true
        case .disableTrailer:
            withTrailer = false
        default:
            super.actionCantUse(action: action)
        }
    }
    
    override func getStringDescription() -> String {
        let mainDesc = super.getStringDescription()
        return mainDesc + "Прицеп подключен: \(withTrailer); Количество колес: \(weelsCount);"
    }
}

class SportCar: Car {
    let afterburnerAvailable: Bool
    
    init(brand: String, creationYear: Int, trunkMaxVolume: Int, afterburnerAvailable: Bool) {
        self.afterburnerAvailable = afterburnerAvailable
        super.init(brand: brand, creationYear: creationYear, trunkMaxVolume: trunkMaxVolume)
    }
    
    override func doAction(action: Actions) {
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
            super.getFromTrunk(volume: volume)
        case .setToTrunk(let volume):
            super.setToTrunk(volume: volume)
        case .activateAfterburner where afterburnerAvailable:
            activateAfterburner()
        case .activateAfterburner where !afterburnerAvailable:
            print("Данная машина не имеет функции форсажа.")
        default:
            super.actionCantUse(action: action)
        }
    }
    
    private func activateAfterburner() {
        print("Форсаж активирован!!!")
    }
    
    override func getStringDescription() -> String {
        let mainDesc = super.getStringDescription()
        return mainDesc + "Форсам доступен: \(afterburnerAvailable);"
    }
}

let car1 = SportCar(brand: "honda", creationYear: 1990, trunkMaxVolume: 100, afterburnerAvailable: false)
car1.doAction(action: .activateAfterburner)
print(car1.getStringDescription())

let car2 = SportCar(brand: "lada", creationYear: 1900, trunkMaxVolume: 100, afterburnerAvailable: true)
car2.doAction(action: .activateAfterburner)
car2.doAction(action: .setTrailer)
print(car2.getStringDescription())

let car3 = TrunkCar(brand: "Volvo", creationYear: 2022, trunkMaxVolume: 3000, weelsCount: 16)
car3.doAction(action: .setTrailer)
print(car3.getStringDescription())

