//: [Previous](@previous)

import Foundation
import UIKit
var str = "Hello, playground"

//: [Next](@next)
//String 结构体 效率要比对象高,一般推荐
//NSString 继承NSObject
var ss :String = "你吗"

for c in ss.characters {
    
}

let name:String? = "name"
let age = 80
let title = "小菜"
let rect = CGRect(x: 0, y: 0, width: 21, height: 34)
//print(name! + String(age) + title)//nil 是不能跟其他有值的一起打印 所以要加!

print("\(name):\(age):\(title):\(rect)")

let l:String?//没有初始化  并不是nil
l = nil

print(l)

// 真的需要格式怎么办

let h = 9
let m = 5
let s = 8

let timeStr = "\(h):\(m):\(s)"

let timeStr1 = String(format: "%02d:%02d:%02d", arguments: [h,m,s])


let sss=(ss as NSString).substringWithRange(NSMakeRange(2, 2))

let ssss = ss.substringFromIndex("你".endIndex)

let gg:Character = "你"


