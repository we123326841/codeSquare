//
//  TestClass.swift
//  Swift(大测试)
//
//  Created by 王浩 on 16/4/5.
//  Copyright © 2016年 cc. All rights reserved.
//

import UIKit

class TestClass: NSObject {
    var _name:String? = "饿の"
    var name:String {
        set{
          //  _name = newValue + "嘻嘻"
        }
        
        get{
            return (_name)!
        }
        
    }
    
    var title:String? {
        didSet{
            print("set")
        }
    }
    
    var title1:String?{
        return "得得"
    }
    
    var title2:String?{
        get {
            return "哈哈"
        }
    }
}
