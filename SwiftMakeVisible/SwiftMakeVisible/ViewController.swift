//
//  ViewController.swift
//  SwiftMakeVisible
//
//  Created by 王浩 on 16/4/29.
//  Copyright © 2016年 cc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = UIColor.redColor()
        
        let u:String? = "dafea"
        
       // if let x = u where x.hasPrefix("da") {
        //    print("得得")
      //  }
        
        guard let x = u where x.hasPrefix("da") else {
            print("呵呵呵")
            return
        }
        
        print(x)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

