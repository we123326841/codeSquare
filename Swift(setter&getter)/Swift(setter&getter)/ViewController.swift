//
//  ViewController.swift
//  Swift(setter&getter)
//
//  Created by 王浩 on 16/3/28.
//  Copyright © 2016年 cc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //懒加载的详细写法
  lazy var dataList:[String]? = {
        print("我在懒加载吗?")
        return ["张三","李四"]
    }()
    
    //懒加载的简单写法
    
    lazy var list:[String]? = ["在是","得得"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//       let p = Person()
//        p._name = "dede"
//        p.name = "得得得得"
//        print("\(p.name)-----\(p._name)")
//    
//        let a = { (x:Int,y:Int) ->String in
//            print("打印打印");
//            
//            return "x=\(x)---y=\(y)"
//            
//        }(23, 32)
//        
//        print(a)
//        
//        print(a)
//
//      let a1 = a(32, 34)
//        print(a1)
       let p = Person()
        p.model = "嘿嘿"
      //  p.model = nil
        p.name = "名字"
        //p.title = "的"
        let pp = p.model
        print(p.model)
        print(p.name)
        print(p.title)
        
        
        let aa:Int? = 32
        print(aa!)
        let aaa = aa!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //print(list)
        
    }


}

