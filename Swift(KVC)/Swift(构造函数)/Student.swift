//
//  Student.swift
//  Swift(构造函数)
//
//  Created by 王浩 on 16/3/25.
//  Copyright © 2016年 cc. All rights reserved.
//

import UIKit

class Student: Person {
    var no:String?
    //子类只能继承指定的构造函数,便利构造函数是本类的
    override init(dict: [String : AnyObject]) {
        super.init(dict: dict)
    }
    
    
    deinit{
        print("Student init")
    }
}
