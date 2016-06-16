//
//  Cat.swift
//  Swift大测试4
//
//  Created by 王浩 on 16/4/11.
//  Copyright © 2016年 cc. All rights reserved.
//

import UIKit

class Cat: NSObject {
    var name:String?
    
    
    init(name:String) {
        self.name = name
    }
    
    
    func jumping(){
        print("\(self.name)跳跳糖")
    }
}
