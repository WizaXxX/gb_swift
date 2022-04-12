import Cocoa

let varA: Double = 2
let varB: Double = 3
let varC: Double = 1

let disc: Double = pow(varB, 2) - (4 * varA * varC)

if disc < 0 {
    print("Нет ответа")
} else if disc == 0 {
    print("Корень равен " + String(-(varB / (2 * varA))))
} else {
    let sqrtDisc = sqrt(disc)
    let varX1 = (-varB - sqrtDisc) / (2 * varA)
    let varX2 = (-varB + sqrtDisc) / (2 * varA)
    print("Первый корень равен " + String(varX1))
    print("Второй корень равен " + String(varX2))
}
