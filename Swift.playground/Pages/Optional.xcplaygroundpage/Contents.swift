//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

// Optional 可选的 可以有值,可以为nil
//init? 表示可选的  说明url 可能nil 可能有值
let url = NSURL(string: "http://www.baidu.com/")
//

print(NSURLRequest(URL: url!))



// ! 程序员认为这里 url 一定有值
if url != nil {
    let request = NSURLRequest(URL: url!)
}


var l :String? = "的你"
//强行解包 因为 ll 不能为nil 而 l 有可能为nil 有可能有值 所以要加! 认为l一定有值
var ll:String  = l!

if let myUrl = url {

    print(myUrl)
}

var oName:String? = "张三"
var oAge: Int? = 0
//多值之间 使用逗号分开
if let name = oName ,age = oAge {

    print(name + String(age))
}
//如果前面的是nil 使用?? 后面的值
let cName = nil ?? "的"
let dName:String
if oName == nil {
       dName = "abc"

} else {

    dName = oName!
}

let hu:String? = "dede"

var hi = 21.3

var dataList: [String]?
dataList = ["zhangsan","lishi","wangwu"]
//dataList? 表示 datalist 可能为nil
let count = dataList?.count ?? 2

var pName:String


//print(pName)

// 带?的不能赋值给 不带问号的
//var y:String? = "dede"
//
var jj:String = "得得"

var y:String? = jj

//表示程序员来程诺dataList 一定有值 ,为nil 就崩
//每次写 ! 强行解包 一定要思考
let count1  = dataList!.count




//测试

let wurl:String? = "dwdqdqw"
print(wurl)
let da = wurl

//let oioi:String = wurl!
//print(oioi)
//如果你确信你的变量能保证被正确初始化，那就可以这么做，否则还是不要尝试为好
let unin:String! = wurl
//print(unin)

let teq:String = "大方法v"

let dad:String! = teq
print(dad)

if let abc = dad {
    print(abc)
}

if let p = wurl where p.hasPrefix("dw") && p.hasSuffix("qwweq"){
    print(p)
}







