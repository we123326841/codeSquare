//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

var a:String = "de"
print(a)

let b:String? = "呃呃"
let c = b


func demoForward(x:Int) -> Int {
    return x + 1
}

func demoBack(x:Int) -> Int {
    return x - 1
}

func demo(b:Bool) -> (Int) ->Int {
    
    return b ? demoForward : demoBack
}


let d = demo(true)

d(31)


//嵌套函数
func demo1(b:Bool) ->(Int) ->Int{
    func  demo2(a:Int) ->Int { return a + 1}
    func  demo3(a:Int) ->Int { return a - 1}
    return b ? demo2 : demo3
}

let d1  = demo1(false)
d1(34)


//inout演练,泛型演练

func swapValue(inout a:Int,inout b:Int)  {
    let c = a
    a = b
    b = c
    
}

var f = 21
var h = 86

swapValue(&f, b: &h)

f
h

let ssss:String? = "dede"

let dw:Bool = (ssss == "dedde")

var r = 32.23
var u = 43.78

var r1 = (Int(r))
var u1 = (Int(u))
swapValue(&r1,b: &u1)
r1
u1

func swapValueTo<T>(inout a:T,inout b:T){
    let c = a
    a = b
    b = c
}

var d8 = "王"
var e = "浩"

swapValueTo(&d8, b: &e)

d8
e
//结构体和枚举可以定义自己的方法，但是默认情况下，实例方法中是不可以修改值类型的属性。
struct Point {
    var x = 0
    mutating func swapValueToo(ee:Int,bb:Int){
        self.x += ee
    }
}

class Stack<T> {
    var items = [T]()
    
    func add(sub:T){
        items.append(sub)
    }
    
    func pop(){
        items.removeLast()
    }
}


let s = Stack<String>()
s.add("呵呵")
s.add("忽忽")
s.add("恩恩")

s.items

s.pop()

s.items





