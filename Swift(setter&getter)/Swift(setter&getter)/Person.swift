//
//  Person.swift
//  Swift(setter&getter)
//
//  Created by 王浩 on 16/3/28.
//  Copyright © 2016年 cc. All rights reserved.
//

import UIKit

class Person: NSObject {
    //属性,oc中还有一个_成员变量,负责记录属性内容
    //重写 getter(懒加载) & setter(给cell设置模型,在模型setter 方法中设置ui界面)
    //常见功能,在swift 中是有特殊写法的
    //一下代码仅供参考
    
    
    var _name:String?//变量_name
    //属性name 类似oc里面的
    var name:String?{
        get{
            return _name
        }
        
        set{
            _name = newValue
        }
    }
    //model:String?{.....}  其中这里面的花括号 并不是闭包 ...(记住记住!!)
    
    var model :String?{
        didSet {
            print("更新 UI\(model)")
        }
    }
    //get only 的简写
    var title: String? {
        return "MR. " + (name ?? "空空")
    }
    //get only 的完整写法
    var title1: String? {
        get{
            return "MR. " + (name ?? "爷爷")
        }
    }
}
