//
//  ViewController.swift
//  Optional
//
//  Created by 王浩 on 16/6/6.
//  Copyright © 2016年 tencent. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let p:Person? = Person()
        print(p?.name)
        print(p!.name)
        let s:String? = "dede"
        print(s)
        if s == "dede" {
            print("正确")
        }
        p?.title = "标题列"
        print(p!.title)
        
       // p?.sex = "dwdw"
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

