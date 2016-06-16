//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)


func text1(x:Int,y:Int) -> String {
    return "x=\(x),,y=\(y)"
}


let f:(Int,y:Int) ->String = text1

f(3, y: 4)

text1(54, y: 21)

let f1 = {(x:String, y:Int) ->String in
    return "呵呵"
}

f1("人才", 23)

let f6 = {(x:String) -> String in
    return x
}


func test2(x:Int, y:(Int,String) ->String) -> Int {
    y(23, "得得")
    return 32
    
}

let u = test2(12) { (x, _) -> String in
    print("\(x),,\(0)")
    return "嘻嘻"
}

print(u)



