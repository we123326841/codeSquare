//
//  Student.swift
//  Swift(构造函数)
//
//  Created by 王浩 on 16/3/25.
//  Copyright © 2016年 cc. All rights reserved.
//

import UIKit

class Student: Person {
    var no:Int
    
//    override init() {
//        print("student init")
//        no = 21
////        super.init()  系统会自动调用这个方法 可以省略不写
//        //如果父类提供了多个构造函数,必须指定构造函数
//        super.init()
//    }
    
    override init(name: String, age: Int) {
        no = 29
        super.init(name: name, age: age)
    }
    // 之类扩展构造函数 ,不需要 override 因为父类没有对应的方法
    init(name: String ,age: Int ,no: Int){
        self.no = no
        super.init(name: name, age: age)
    }


}
