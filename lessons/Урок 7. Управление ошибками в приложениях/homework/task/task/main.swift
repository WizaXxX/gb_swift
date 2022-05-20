//
//  main.swift
//  task
//
//  Created by WizaXxX on 16.05.2022.
//

import Foundation

enum CarError: LocalizedError {
    case engineWasStart
    case engineWasStop
    
    var errorDescription: String? {
        switch self {
        case .engineWasStart:
            return "Двигатель ранее уже был запущен"
        case .engineWasStop:
            return "Двигатель ранее уже был остановлен"
        }
    }
}

struct Car {
    private var doorIsOpen: Bool = false
    private var engineIsStart: Bool = false
    
    mutating func openDoor() -> Bool? {
        guard !doorIsOpen else {
            return nil
        }
        
        doorIsOpen = true
        return true
    }
    
    mutating func closeDoor() -> Bool? {
        guard doorIsOpen else {
            return nil
        }
        return nil
    }
    
    mutating func startEngine() throws -> Bool {
        guard !engineIsStart else {
            throw CarError.engineWasStart
        }
        print("Двигатель запущен")
        engineIsStart = true
        return true
    }
    
    mutating func stopEngine() throws -> Bool {
        guard engineIsStart else {
            throw CarError.engineWasStop
        }
        print("Двигатель остановлен")
        engineIsStart = false
        return true
    }
}

var myCar = Car()
print(myCar.closeDoor())
print(myCar.openDoor())

do {
    try myCar.stopEngine()
    try myCar.startEngine()
} catch CarError.engineWasStop {
    print("Двигатель ранне уже был остановлен")
} catch CarError.engineWasStart {
    print("Двигатель ранее уже был запущен")
}

do {
    try myCar.stopEngine()
} catch let errorInfo {
    print(errorInfo.localizedDescription)
}
