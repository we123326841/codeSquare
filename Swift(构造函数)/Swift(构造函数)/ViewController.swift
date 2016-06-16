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
        // Do any additional setup after loading the view, typically from a nib.
      //let p = Person()
       // print("\(p.name),\(p.age)---p:\(p)")
        
//        let s = Student()
//        print("\(s.name)...\(s.age)...\(s.no)")
        
//      let p =  Person(name: "张", age: 44)
//        print(p.name)
        let ss = Student(name: "haha", age: 12, no: 21)
        
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

