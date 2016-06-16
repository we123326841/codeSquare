//
//  Person.swift
//  Swift大测试2
//
//  Created by 王浩 on 16/4/8.
//  Copyright © 2016年 cc. All rights reserved.
//

import UIKit

class Person: NSObject {
    var name:String?
    var age: Int?
    var t:Test = Test()
    
//    init(name:String,age:Int) {
//        self.name = name
//        self.age = age
//    }
//    convenience init?(namee:String,agee:Int) {
//       // if agee < 10 || agee > 100{
//         //   return nil
//        //}
//        
//        self.init(name: namee, age: agee)
//        
//    }
    
    override init() {
        
    }
    
    func showMe() {
        print("S.showMe")
    }

}
