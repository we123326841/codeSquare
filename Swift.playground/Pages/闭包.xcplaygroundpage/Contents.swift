//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

func sum (num1 x:Int,num2 y:Int) ->Int {
    return x + y
}

let sum1 = sum
sum(num1: 12, num2: 21)

//闭包的定义 :大括号括起来的叫闭包
//闭包类似于oc 中的block
//1.形参,返回值,代码都包含在{} 中
//简单的闭包
//最简单的闭包,如果没有参数/返回值 统统(in)都可以省略
let demoFunc = {
    print("hello")
}

demoFunc()

//let demoFunc2 = {(num1 x:Int, num2 y:Int) ->Int in
//    return x + y
//}


//in 就是区分函数定义 和代码实现的
let demoFunc3 = {(x:Int,y:Int) ->Int in
    return x + y
}

demoFunc3(32 , 21)

let demoFunc4 = {() ->Void in
    print("dedededede")
}

let demoFunc5 = {() ->() in
    print("ddddddd")
}

let  demoFunc6 = {
    print("ssssss")
}

demoFunc4()
demoFunc5()
demoFunc6()

let hh:() ->Void

hh = {() ->Void in
    print("得得得得水电气")
}


hh()

//尾随闭包
let digitNames = [0:"Zero",1:"One",2:"Two",3:"Three",4:"Four",5:"Five",6:"Six",7:"Seven",8:"Eight",9:"Nine"]

let numbers = [16,58,510]

let aaa = numbers.map { ( x) -> String in
  //  print(x)
    var output = ""
    var xx = x
    while xx > 0 {
       output = digitNames[xx % 10]! + output
        xx /= 10
    }
    print(output)
    return output
}




