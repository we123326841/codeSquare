//
//  Person.swift
//  Swift(大测试)
//
//  Created by 王浩 on 16/3/30.
//  Copyright © 2016年 cc. All rights reserved.
//

import UIKit

class Person: NSObject {
    var name:String?
    var age:Int = 0
    
    
    override init() {
        
    }
    
    init(dict:[String : AnyObject]) {
        super.init()
        print("Person===\(self)")
        setValuesForKeysWithDictionary(dict)
    }
    
   convenience init?(x:Int,dict:[String : AnyObject]) {
        if x < 10 || x > 100 {
            return nil
        }
        self.init(dict: dict)
    }
    
    var title:String?{
        didSet {
            print("\(title)")
        }
    }
    
    var wenZhang:String?{
        get{
            return "haha" 
        }
    }
    
    var wenZhang1:String?{
        return "嘻嘻"
    }
    
    
    
}
