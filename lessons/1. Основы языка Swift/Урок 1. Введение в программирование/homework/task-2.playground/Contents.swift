import Cocoa
import Darwin

let cathetusA: Double = 6
let cathetusB: Double = 8
let hypotenuse = sqrt(pow(cathetusA, 2) + pow(cathetusB, 2))

let area = cathetusA * cathetusB * 0.5
let perimeter = cathetusA + cathetusB + hypotenuse

print("Площадь треугольника = " + String(area))
print("Периметр треугольника = " + String(perimeter))
print("Гипотенуза треугольника = " + String(hypotenuse))
