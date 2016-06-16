//
//  ViewController.swift
//  Swift(构造函数)
//
//  Created by 王浩 on 16/3/25.
//  Copyright © 2016年 cc. All rights reserved.
//

import UIKit
//在Swift 中 默认所有的类 都在全局共享的 不需要做任何引用 ,就可以直接使用 
// 是在同一个"命名空间"下全局共享默认情况下"命名空间"就是项目名称
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//      let p = Person(dict: ["name":"这种人","age":21,"xxx":"222"])
//        print("\(p.name)-----\(p.age)")
        
        //let s = Student(dict: ["name":"哈哈","age":27,"no":"111","xxx":"222222"])
        let s = Student(name: "积极", age: 13)
        s?.name = "鸡巴"
    
        //unwrapping an Optional value 解包一个可选值的时候 发现为nil 
        //s? 可能有 可能没有  有的话就得到属性 没有的话 就为nil
        //s! 程序员程诺它不是nil
        print("\(s?.name)----\(s?.age)----")
       // let  a:Int = 2
        
        
        
        
       // let p: Person? = nil
        
       // print("\(p!.name)")
        
        
        let p:[String] = ["dede","dede的"]
        
       print("---------\(p.count)")
        
        var callBack:((Int) ->())
        
        callBack = {(x:Int) ->() in
            print("你妹..\(x)")
        }
        
        callBack(31)
        
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

