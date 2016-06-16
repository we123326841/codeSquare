//
//  Student.swift
//  Swift大测试2
//
//  Created by 王浩 on 16/4/8.
//  Copyright © 2016年 cc. All rights reserved.
//

import UIKit

class Student: Person {
    
    override var name: String?{
        willSet{
          //  print("\(name)\(newValue)")
         //   super.name = name
        }
        
    
    }
    
//    override init(name: String, age: Int) {
//        super.init(name: name, age: age)
//    }
    
    
    override init(){
        
    
    }
    
    
    func name1()-> String{
        return super.name!
    }
    
    var title:String?{
        willSet{
            print("搞些么比\(title)\(newValue)")
        }
        
        didSet{
            print("娘们\(title)")
        }
    }
    
    var xiongWei:String?{
        set{
            print("set\(newValue),,,,,\(xiongWei)")
        }
        
        get{
            print("get")
            return "什么逼"
        }
        
    }
    
    override func showMe() {
        super.showMe()
        print("S.showMe")
    }
    
}
