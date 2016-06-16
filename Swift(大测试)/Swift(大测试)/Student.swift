//
//  Student.swift
//  Swift(大测试)
//
//  Created by 王浩 on 16/3/30.
//  Copyright © 2016年 cc. All rights reserved.
//

import UIKit

class Student: Person {
    var no:Int?
    
    override init(dict: [String : AnyObject]) {
        no = 1001
       

        super.init(dict: dict)
         print("Student===\(self)")
    }
}
