//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)
//格式:func 函数名(形参列表) -> 返回类型{//代码实现}
func sum(x:Int,y:Int) -> Int{
    return x+y
}
//调用函数 函数名(值1,参数名:值2)
sum(32, y: 3)

//外部参数 num1 num2 是供外部调用的 程序员参考的
//保证函数的语义更加清晰
//x, y是内部参数 函数内部使用
func sum1(num1 x:Int , num2 y:Int) -> Int {
    return x + y
}

sum1(num1: 32, num2: 1)

//返回值 "->"
//没有返回值 有三种写法 ,主要是为了闭包

//1.直接省略
//2.-> Void
//3.->()

func demo(){
    print("xixi")
}

func demo1() -> Void{
    print("HUHU")
}

func demo2() ->(){
    print("wiwi")
}

demo()
demo1()
demo2()


func demo3(str1 x:String,num2 y:Int) ->Int{
    return y
}

var f:String? = "dede"
let d:String = f!
demo3(str1: f!, num2: 21)


//特殊函数 inout修饰  可以在函数内部改变外部参数 但是不能传常量和字面量 (因为这些是不能变的) 当我们传入的时候,在变量名字前面用&符号修饰表示,传递给inout参数,表明这个变量在参数内部是可以被改变的
var someInt = 7
var anotherInt = 107


func swapTwoInts(inout a:Int ,inout b:Int){
     a = 31
    
    b = 1
}

swapTwoInts(&someInt, b: &anotherInt)

someInt
anotherInt


//函数类型作为参数类型

func demo9(x:Int ,y:Int) -> String {
    print("x==\(x),y==\(y)")
    return "哈哈哈"
}

func demo6(op:(Int,Int)->String,oo:Int){
    op(31, 34)
}


demo6(demo9, oo: 21)

func stepForward(input:Int) -> Int {
    return input + 1
}

func stepBackward(input:Int) -> Int {
    return input - 1
}
//函数作为返回值
func chooseStepFunc(backward:Bool) ->(Int) -> Int {
    return backward ? stepForward:stepBackward
}

 let c = chooseStepFunc(false)
 c(32)

//嵌套函数



func chooseStepFunction(b:Bool) ->(Int) ->Int {
    func setfor(input:Int) ->Int{return input + 1}
    func setback(input:Int) ->Int{return input - 1 }
    return b ? setfor:setback
}

let aaa = chooseStepFunction(true)
aaa(12)
//aaa

//sort函数

let names = ["allen","jacky","yanni","jeff"]
func sort1(a:String,b:String) -> Bool {
    return a > b
}
  let n = names.sort(sort1)
let cc = { (a:String , b:String) -> Bool in
    return a > b
}

 let n1 = names.sort(cc)

names.sort { (a, b) -> Bool in
    a > b
}

names.sort(){ (a, b) -> Bool in
    a > b
}

names.sort({ (a, b) -> Bool in
    a > b
    }
)


//递增

func funcAdd(x:Int) -> () ->Int {
    var y = 0
    
    func doneFunc()->Int{
        y += x
        return y
    }
    
    return doneFunc
}
//引用类型
var r = funcAdd(10)

r()
r()
r()

let r1 = r
r1()

var rr = funcAdd(10)
rr()
rr()
rr()


// 尾随闭包

func hoho(x:(Int)->Void ) -> String {
    print(21)
    x(45)
    return "忽忽"
}

hoho() { (u) in
    print("呵呵呵:\(u)")
}


