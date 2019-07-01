import UIKit
import Foundation

var str = "Hello, playground"
var array = [Int]()

for int in 1...5 {
	array.append(int)
}
print(array)

func getIndex(of int: Int) -> Int? {
	guard let indexOfInt = array.firstIndex(of: int) else { return nil }
	print(indexOfInt)
	return indexOfInt
}

getIndex(of: 3)
