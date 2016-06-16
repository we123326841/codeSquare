//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)
//swift 里面只有true /false
let num = 20

if num>12 {
    print(12)
}

//必须要指明逻辑结果 否则出错 (与oc还是存在区别的)
//if num {
//    print(12)
//}

let a = 80
let b = 20

let c = a > b ? 100:-100
print(c)