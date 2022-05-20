import Cocoa

var myArray: [Int] = []
for i in 2...Int.max {
    
    guard myArray.count < 100 else {
        break
    }
    
    var isSimple = true
    for value in myArray {
        if i % value == 0 {
            isSimple = false
            break
        }
    }
    
    if isSimple {
        myArray.append(i)
    }
}

print(myArray)
