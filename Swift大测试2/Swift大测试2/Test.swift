//
//  Test.swift
//  Swift大测试2
//
//  Created by 王浩 on 16/4/18.
//  Copyright © 2016年 cc. All rights reserved.
//

import UIKit

class Test: NSObject {
    var age:Int = 0
    
    override init(){
        print("Test被加载")
    
    }
    
   convenience init(age:Int){
        self.init()
    self.age = age
    self.providesw()
    }
    
    class func NAAN() {
        print(self)
        self.NAdwAN()
    }
    
    
    class func NAdwAN() {
        print(self)
        
    }
    
    func providesw(){
        
    }
}
