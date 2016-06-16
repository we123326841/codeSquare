//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)
//常量跟变量   优先使用常量  除非值经常要改  就使用变量
for var i = 0; i < 10 ; i++ {
    print(i)

}
print("--------------")
for i in 0..<10 {
    print(i)
}

let range  = 0..<10
let range1 = 0...10
print("--------------")
for i in range1 {
    print(i)
}