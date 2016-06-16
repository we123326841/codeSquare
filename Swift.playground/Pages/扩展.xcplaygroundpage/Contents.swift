//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)
extension Double {
    var km :Double{
        return self*1000
    }
    var m:Double{
        return self
    }
    var mm:Double {
        return self/1000
    }
    
    

}

let a = 34.43.km
     a
let b = 34.43.mm


struct Size {
    var width = 0.0 ,height = 0.0
}

struct Point {
    var x = 0.0, y = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
}

//Rect(origin: <#T##Point#>, size: <#T##Size#>)

extension Rect{
    init(center:Point,size:Size){
        var x = center.x
        var y = center.y
        x = x + size.width/2
        y = y + size.height/2
        self.init(origin:Point(x: x, y: y),size:size)
        
    }
}

let p = Point(x: 2, y: 2)
let s = Size(width: 2, height: 2)
  let r = Rect(center: p, size: s)

r.origin.x
r.origin.y






