//
//  Person.swift
//  Swift(构造函数)
//
//  Created by 王浩 on 16/3/25.
//  Copyright © 2016年 cc. All rights reserved.
//

import UIKit
//如果没有实现构造方法 会执行父类的构造方法
class Person: NSObject {
    var name:String?
    //如果要使用kvc 给对象初始值 ,"基本数据"类型 必须要设置初始值 并且不能写成可选类型(Int?)
    var age:Int = 0
    
    
    
    //convenience 便利的构造函数
    /**
        1.作用:判断参数条件是否合法
        2.传递重要/常用参数
        3.如果条件不满足,可以返回nil 只有'便利'的构造函数,才允许返回nil
        4.'指定'的构造函数是不允许返回nil的,必须要返回一个对象
        5.'指定构造函数',默认的都是指定的 ,ios开发中,有一个技巧 designated initializer
        6. 只有便利构造函数中可以调用 self.init()
     */
    convenience init?(name:String ,age:Int) {
        if age < 0 || age > 1000 {
            return nil
        }
        //便利构造函数可以调用指定构造函数
        self.init(dict: ["name":name , "age":age])
    }
    
    
    
    
      init(dict:[String : AnyObject]){
        
        super.init()
        //这句话必须跟在super.init之后 就是本类跟父类属性全部初始化之后才调用
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forKey key: String) {
        print("key ----\(key):value ----\(value)")
        super.setValue(value, forKey: key)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        print("------\(key):value ----\(value)")
        //super.setValue(value, forUndefinedKey: key) //这个必须要注释掉 否则就会崩溃
    }
    
    deinit{
        print("Person init")
    }
    
}
