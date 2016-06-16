//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

let a = {
}


func test(x:()->()) -> Int {
    
    return 2
}

test(a)


func test1(x:Int,y:(n:Int,s:String) ->String ,z:(Int) ->Int) -> Int {
    print(x)
   let s = y(n: 88, s: "法法")
    print(s)
    let ss = z(65)
    print(ss)
    return 12
}


let a1=test1(12, y: { (x, e) -> String in
    print("x=\(x)---y=\(e)")
    return "x=\(x)---y=\(e)"
    }) { (z) -> Int in
        return z
}


let r:Int

r = 21

var r1:Int
r1 = 22


let b1 = { (x:Int ,y:String) ->String in
    print("得得得\(y)")
    return "你妹"
}

let d = b1(12, "哈哈")
print(d)


