//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

var a:String? = "dede"

let b:String = a!


//闭包练习
let b1 = {(x:Int ,y:Int) ->String in
        return "得得"
}

let b3:(Int,Int) ->String

b3 = {(x:Int,z:Int) ->String in
    return "尼玛的"
}

let b2 = b1

b1(22,2)

b2(2,2)

b3(21,12)


let b4 = {
    print("哈哈")
}

let b5 = { () ->() in
    print("几把")
}

let b6 = { () ->Void in
    print("喝喝")
}

let b7:() ->()
b7 = {
    print("呃呃呃")
}

b7()
b6()

let b8 = { () ->Int in
    return 32
}

let b9 = { (x:Int) ->() in
    print("da")
}

b8()

b9(2)

func hehe(num1 x:Int) ->Int{
 return x
    
}

func hehe1(x:Int) ->Int {
    return x
}

hehe(num1: 21)

hehe1(12)


func hehe2(x:Int,y:Int){
    print(x+y)
}

hehe2(112, y: 8)

func hehe3(x:Int,y:Int) ->Void{
    print(x+y)
}

hehe3(34, y: 2)

func hehe4(num1 x:Int,num2 y:Int) ->(){
    print(x+y)
    
//    return x + y
}


let y = hehe4

let y1 = hehe3

y(num1: 12, num2: 1)

//hehe4(num1: 12, num2: 2)

let e = { (x:Int ,y:Int) ->Int in
    print(x+y)
    return x+y
}
//闭包唯一跟函数不同的地方是 不能取外部参数
let e1 = {(x:Int, y:Int) ->Int in

    return x + y
}

let e2 = e1

e2(12, 3)

e1(1, 3)
//闭包无返回值 有参数 还是要写完整
let e3 = {(x:Int, y:Int) ->Void in
    print(21)
}


let y3 = e3
//闭包无返回值 ,无参数 可以都省略
let e4 = {
    print(12)
}

//函数跟闭包都可以赋值 类型一致









