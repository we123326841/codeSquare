//
//  TestClass1.swift
//  Swift(大测试)
//
//  Created by 王浩 on 16/4/5.
//  Copyright © 2016年 cc. All rights reserved.
//

import UIKit

class TestClass1: NSObject {
    var totalSteps:Int = 0 {
        willSet(newTotalSteps) {
            print("will他妈的\(newTotalSteps)")
        }
        
        didSet {
            if totalSteps > oldValue {
                
                print("did他妈的\(totalSteps)")
            }
        
        }
    }
}
