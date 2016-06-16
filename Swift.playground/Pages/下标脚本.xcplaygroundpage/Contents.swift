//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)
struct demo{
    let mulitiplier:Int
//    
//    subscript(index:Int) ->Int{
//        return index * mulitiplier
//    }
    subscript(inss:Int) ->Int{
        return inss + mulitiplier
    }
}


var e = ["cat":3,"dog":56]

e["mouth"] = 5

e

 let d = demo(mulitiplier: 4)
 let g = d[3]

assert(true, "你妹")

print("得到")



struct demo1{
    let mulitiplier:Int
    //
    //    subscript(index:Int) ->Int{
    //        return index * mulitiplier
    //    }
    subscript(inss:Int,insss:Int) ->Int{
        set{
            print("setSet,\(inss),\(insss)")
        }
        get{
            print("getGet,\(inss),\(insss)")
            return 43
        }
    }
}

  var ddd = demo1(mulitiplier: 21)
    let dddd = ddd[21,34]
    print(dddd)
    ddd[23,41] = 32


