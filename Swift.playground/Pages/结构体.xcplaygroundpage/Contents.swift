//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)
struct Resolution {
    var width = 0
    var height = 0
    
}

var huhu:String

var r = Resolution()

r.height = 21

print(r.height)

class VideoMode: NSObject {
    var r = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name:String?
}

var v = VideoMode()
v.r.height = 21
v.r.width = 45
print(v.r.height)
print(v.r.width)

var u = Resolution(width: 32, height: 75)
print(u.height)


