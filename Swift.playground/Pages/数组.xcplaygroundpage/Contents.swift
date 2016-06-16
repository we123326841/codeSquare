//: [Previous](@previous)

import Foundation
import UIKit
var str = "Hello, playground"

//: [Next](@next)
// [String] 表示数组是存放字符串的数组

let array = ["zhangsan","lisi"]

//let array:[String]? = ["zhangsan","lisi"]
//数组中存在的数据类型不一致,自动推导的格式 是 [NSObject]
let array2 = ["zhangsan",18,UIView()]
//提问:日常开发中 类型一直 的数组多
//数组的遍历,是通过下标来访问的

//遍历数组

for name in array {
    print(name)
}

// 可变 var & 不可变 let
//let list = ["zhangsan", "lisi"]
//list.append("wang")//不可变的数组不能用此方法
var list = ["张三","李四"]
list.append("王五")
let p=list.removeFirst()
let s=list.removeLast()

print("\(p):\(s)")
print(p+":"+s)
list
list.append("hehe")
list.append("大的")
//list.removeAll()

list.removeAtIndex(2)
list

print(list.capacity)
list
list.removeAll(keepCapacity: true)
print(list.capacity)
list
//1.定义并且实例化一个只能保存字符串的数组
var arrayM = [String]()
print("\(arrayM.capacity)")
for i in 0...16{
    arrayM.append("hello:\(i)")
    print("i==\(i)---数组容量\(arrayM.capacity)")
}

arrayM.removeAtIndex(2)
print(arrayM.capacity)

//定义数组 数组能够保存整数,并且实例化数组对象()
var arrayM2 = [Int]()//()表示实例化数组对象 就相当于java的构造函数
//定义数组类型 ,指定数组能够保存整数,并没有创建数组对象,无法向数组添加对象
var arrayM3:[Int]//必须要实例化
arrayM3 = [Int]()
print("------\(arrayM2.capacity)")
arrayM2.append(1)
arrayM3.append(2)
print("------\(arrayM2.capacity)")

var arrayM4 = [Int](count:32, repeatedValue:4)

print(arrayM4.capacity)

var arr1 = [1,2,3,4,5]
var arr2 = [6,7,8,9,10]
var arr3 = ["1","2"]
//数组类型必须一致 才能相加
arr1 = arr1 + arr2


//数组的赋值

var a = [1, 2, 3]
var b = a
var c = a
a[0] = 42

a
b
c

//
class Person{
    var name:String?
    init(name:String){
        self.name = name
    }
}

var person1:Person = Person(name: "小李")
var person2:Person = Person(name: "小华")
var person3:Person = Person(name: "小张")
var arr = [person1,person2,person3]
print("\(arr[0].name)")

person1.name = "小计"
print("\(arr[0].name)")






