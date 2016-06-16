//
//  Person.swift
//  Optional
//
//  Created by 王浩 on 16/6/7.
//  Copyright © 2016年 tencent. All rights reserved.
//

import UIKit

class Person: NSObject {
   internal var name:String?
    
    
    public var title:String = ""{
        didSet{
            print("title==\(title)")
        }
        
        willSet{
            print("newValue ==\(newValue)")
        }
    }
    
    internal var sex:String{
        get{
            return self.sex
        }
    }
    
}
