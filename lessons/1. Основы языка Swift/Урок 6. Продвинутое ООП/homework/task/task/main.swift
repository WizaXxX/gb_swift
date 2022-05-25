//
//  main.swift
//  task
//
//  Created by WizaXxX on 04.05.2022.
//

import Foundation

protocol WithName {
    var name: String { get set }
}

struct Queue<T: Equatable & WithName> {
    private var elements: [T] = []
    
    mutating func add(elemnt: T) {
        elements.append(elemnt)
    }
    
    mutating func pop() -> T? {
        return elements.removeFirst()
    }
    
    mutating func filter(for_name predicate: (String) -> Bool) {
        
        for element in elements {
            if !predicate(element.name) {
                let index = elements.firstIndex(of: element)
                elements.remove(at: index!)
            }
        }
    }
    
    mutating func filter(_ predicate: (T) -> Bool) {
        
        for element in elements {
            if !predicate(element) {
                let index = elements.firstIndex(of: element)
                elements.remove(at: index!)
            }
        }
    }
    
    func getFiltred(_ predicate: (T) -> Bool) -> Queue<T> {
        var tmpQueue = Queue()
        for element in elements {
            if predicate(element) {
                tmpQueue.add(elemnt: element)
            }
        }
        return tmpQueue
    }
    
    subscript(index: Int) -> T? {
        get {
            return elements.indices.contains(index) ? elements[index] : nil
        }
        
        set(newValue){
            if elements.indices.contains(index) {
                if let newValueSafe = newValue {
                    elements[index] = newValueSafe
                }
            }
        }
    }
    
}

extension Queue: CustomStringConvertible {
    var description: String {
        var desc = ""
        for element in elements {
            let indexOfElement = elements.firstIndex(of: element)
            desc += "\(indexOfElement!) - \(element.name)\n"
        }
        return desc
    }
}

struct ActionType1: WithName,Equatable {
    var name: String
}

struct ActionType2: WithName,Equatable {
    var name: String
}

var queueType1 = Queue<ActionType1>()

let action1 = ActionType1(name: "Test 1")
let action2 = ActionType1(name: "Test 2")
let action3 = ActionType1(name: "Test 3")
let action4 = ActionType1(name: "Test 42")

queueType1.add(elemnt: action1)
queueType1.add(elemnt: action2)
queueType1.add(elemnt: action3)
queueType1.add(elemnt: action4)

print(queueType1)
print(queueType1.getFiltred({$0.name == "Test 2"}))
//queueType1.filter(for_name: {$0 == "Test 1"})
queueType1.filter({ element in
    element.name.contains("2")
})
print(queueType1)
queueType1[1] = ActionType1(name: "Tererer")
print(queueType1)


