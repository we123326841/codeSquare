//
//  ViewController.swift
//  网络访问-Swift
//
//  Created by 王浩 on 16/3/24.
//  Copyright © 2016年 cc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       let a = NSURL(string: "http://www.baidu.com")
        NSURLSession.sharedSession().dataTaskWithURL(a!) { (data, _, _) in
         let result  = try!NSJSONSerialization.JSONObjectWithData(data!, options: [])
            
            print(result)
        }.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

