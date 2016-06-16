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
    var age:Int?
    
    
    //没有 func override 重写
    
    //构造方法 1给本类的属性分配内存空间  2给本类的属性赋值  3调用父类的init实例化 (也可不写)
//    override init() {
//         print("person init")
//        name = "王五"
//        age = 21
//        super.init() //这句可写 可不写  因为不会执行什么很重要的代码 而且系统会默认执行父类的构造方法
//    }
    
    //重载构造函数,指定参数
    //如果没有实现 init() 构造函数,一旦实现了其他的构造函数
    //默认的init() 构造函数将无法被访问
    
    init(name:String ,age:Int){
        self.name = name
        self.age = age
    
    }
}
