//
//  Pz.swift
//  Swift(大测试)
//
//  Created by 王浩 on 16/3/30.
//  Copyright © 2016年 cc. All rights reserved.
//

import UIKit

class Pz: Pc {
    init(num:Int){
        super.init(str: "dede")
    }
    
    required init(str: String) {
        fatalError("init(str:) has not been implemented")
    }
    
    
   // required修饰符的使用规则
   // required修饰符只能用于修饰类初始化方法。
   // 当子类含有异于父类的初始化方法时（初始化方法参数类型和数量异于父类），子类必须要实现父类的required初始化方法，并且也要使用required修饰符而不是override。
   // 当子类没有初始化方法时，可以不用实现父类的required初始化方法。
    
    
   
}
