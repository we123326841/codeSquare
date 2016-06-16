//
//  ViewController.swift
//  Swift知识
//
//  Created by 王浩 on 16/6/15.
//  Copyright © 2016年 tencent. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var b:String? = "dw"
     //   let a:String! = b
      //  print(a)
        let a = b!
        print(a)
        if b! == "dw"{
            print("是的")
        }
        
//        b = nil
        
        if let f = b where b == "dw" {
            print("的")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

