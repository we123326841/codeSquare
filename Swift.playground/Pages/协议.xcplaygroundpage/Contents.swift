//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

protocol AnotherProtocol {
    //协议中 要用static 不能用calss
    //{get set}表示可读可写 不能用常量或者只读的计算属性
    static var someTypeProperty:Int {get set}
    
}

protocol AnotherProtocol1 {
    //协议中 要用static 不能用calss
    //{get set}表示可读可写 不能用常量或者只读的计算属性
    var someTypeProperty:Int {get set}
    
}

@objc protocol FullyNamed  {
    //只读的  不仅可以只读 有需要的话 也可以是可读可写
    var fullName: String{ get }
    var someTypeProperty:Int {get set}
    func random() ->Double
    optional func beginCompare() -> Bool
    
}

@objc protocol FullyNamed1 {

    optional func hihi() -> String
}

class demo: FullyNamed,FullyNamed1{
    var a = 13
    var b = 43
    
   // let fullName: String = "" 可以
    @objc var fullName: String = "" //可以
    
//    let someTypeProperty: Int = 0 //不可以
//    var someTypeProperty: Int = 0 可以
    @objc var someTypeProperty: Int = 0 {
       // return 32 不能get
        didSet{
            print("得得得")
        }
    }
    
//    var someTypeeProperty: Int {
//        return 53
//        
//    }
//    
//    @objc func random() -> Double {
//        a = a + b
//        return Double(a)
//    }
    @objc func random() -> Double {
        a = a + b
                return Double(a)

    }
    
    @objc func beginCompare() -> Bool {
        return true
    }

}

 var de = demo()
    de.random()
    de.random()
 let p1 = de as FullyNamed
print(p1)
print(p1.beginCompare?())


    let p2 = de as FullyNamed1

print(p2.hihi?())



class demo2: AnotherProtocol1 {
    var someTypeProperty: Int{
        set{
            print("dede")
        }
        
        get{
            return 43
        }
    }
}


let sss:AnotherProtocol1? = demo2()




