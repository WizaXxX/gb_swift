import Cocoa

func addNewFibonacciNumberToArray(array: inout [Int]) {
        
    if array.count < 2 {
        array.append(1)
        return
    }
    
    let currentIndex = array.count - 1
    let value1 = array[currentIndex]
    let value2 = array[currentIndex - 1]
    
    array.append(value1 + value2)
    
}

var fNumbers: [Int] = []
for _ in 1...50 {
    addNewFibonacciNumberToArray(array: &fNumbers)
}
print(fNumbers.count)
