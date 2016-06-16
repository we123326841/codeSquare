//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)
let http404Error = (404 , "Not Found")
let (x,y) = http404Error
print(x)
print(y)

print(http404Error.0)
print(http404Error.1)

let (z,v) = ("得得",21)
 print(z)

print(v)

let (g,_) = http404Error

let  http300Status = (statusCode: 300,decription:"ok")

print(http300Status.decription)

print(http300Status.statusCode)

print(http300Status.0)

        