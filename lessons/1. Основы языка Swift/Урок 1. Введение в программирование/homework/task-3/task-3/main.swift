//
//  main.swift
//  task-3
//
//  Created by WizaXxX on 12.04.2022.
//

import Foundation

func getNumbers() -> Double {
    
    var numbers: Double = 0
    
    if let readData = readLine() {
        if let doubleData = Double(readData){
            numbers = doubleData
        } else {
            print("Нужно указать корректное число")
            exit(1)
        }
    } else {
        print("Необходимо указать число")
        exit(1)
    }
    
    if numbers <= 0 {
        print("Число должно быть больше 0")
        exit(1)
    }
    
    return numbers
}

print("Укажите сумму вклада")
var totalSum = getNumbers()

print("Укажите процент по вкладу")
let depositInterest = getNumbers()

var i = 1
let total = 5 * 12
let depositInterestFromMonth = depositInterest / 12

repeat {
    let persentSum = depositInterestFromMonth * totalSum / 100
    totalSum = totalSum + persentSum
    i += 1
} while i <= total

print("Итоговая сумма через 5 лет = " + String(round(totalSum * 100) / 100))

