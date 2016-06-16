//
//  ViewController.swift
//  Swift(构造函数测试)
//
//  Created by 王浩 on 16/3/28.
//  Copyright © 2016年 cc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
      //  let p = Person()
       // print("\(p.name),,\(p.age)")
//        let s = Student(name: "哈哈", age: 81)
        
        let p = Person(name: "得得得", aage: 18)
            print(",,\(p!.age),,\(p!.name)")
        
    
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

