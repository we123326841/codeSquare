//
//  Person.swift
//  Swift(构造函数测试)
//
//  Created by 王浩 on 16/3/28.
//  Copyright © 2016年 cc. All rights reserved.
//

import UIKit

class Person: NSObject {
    var name:String
    var age:Int
    
//    override init() {
//        print("Person init")
//        name = "王五"
//        age = 21
//        super.init()
//    }
    
    
    
    convenience init?(name:String,aage:Int){
        if aage < 10 || aage > 100 {
            return nil
        }
    
    self.init(name:name,age:aage)
   
    }
    
    
//    init(dict:[String:AnyObject]) {
//        super.init()
//        setValuesForKeysWithDictionary(dict)
//    }
    
//        init(name:String,age:Int) {
//            print("Person init(String,Int)")
//            self.name = name
//            self.age = age
//            super.init()
//        }
    
    
    init(name:String , age:Int) {
            self.name = name
            self.age = age
            super.init()
    }
    
    
}
