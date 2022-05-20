import Cocoa

// task - 1
func isEven(number: Int) -> Bool {
    return number % 2 == 0
}

// task - 2
func isDividedIntoThree(number: Int) -> Bool {
    return number % 3 == 0
}

let test1 = isEven(number: 25)
let test2 = isEven(number: 24)

let test3 = isDividedIntoThree(number: 6)
let test4 = isDividedIntoThree(number: 8)

// task - 3
var myArray: [Int] = []
for i in 1...100 {
    myArray.append(i)
}

//task - 4
for value in myArray {
    if isEven(number: value) || !isDividedIntoThree(number: value){
        myArray.remove(at: myArray.firstIndex(of: value)!)
    }
}
