//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)
//定义字典 [String : NSObject]
//[key : value]
// key 通常都是字符串
// value 可以是任意类型
var dict = ["name":"张三","age":"18"]

//可变 var & 不可变 let
//let 不可以用 dict[key] = value
dict["height"] = "98"
//key相同会覆盖
dict["name"] = "haha"
dict

//遍历

for (k,v) in dict{
    print("key:\(k) value:\(v)")
}



//合并

var dict1 = ["name":"小李","sex":"男"]
for (k,v) in dict{
    print("key:\(k) value:\(v)")
    dict1[k] = v
}
dict1

var dict2 = [12:"嘚嘚",13:"哈哈"]

//字典的赋值

var ages =  ["Peter": 23, "Wei": 35, "Anish": 65]
var copyAges = ages

copyAges["Peter"] = 29
copyAges
ages
