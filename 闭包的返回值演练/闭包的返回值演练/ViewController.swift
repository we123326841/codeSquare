//
//  ViewController.swift
//  闭包的返回值演练
//
//  Created by 王浩 on 16/3/23.
//  Copyright © 2016年 cc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
        let re = CGRect(x: 0, y: 20, width: view.bounds.width, height: 44)
      let sv = HMLabelScrollView(frame: re, numberOfLabel: { () -> Int in
        return 10
      }) { (index) -> UILabel in
             let label = UILabel()
             label.text = "Hello\(index)"
            label.font = UIFont.systemFontOfSize(18)
            label.sizeToFit()
            label.font = UIFont.systemFontOfSize(14)
            return label
        }
        //在swift中 可以不用写self.view  直接用view
        view.addSubview(sv)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollView(frame:CGRect, numberOfLabel:()-> Int,labelOfIndex:(index: Int)->UILabel ) ->UIScrollView {
        //1.实例化 scrollView 并且指定大小&位置
       let sv = UIScrollView(frame: frame)
        sv.backgroundColor = UIColor.lightGrayColor()
         let count = numberOfLabel()
        print("数量:\(count)")
        let margin:CGFloat = 8
        var x = margin
        for i in 0..<count {
            let label = labelOfIndex(index: i)
            
            label.frame = CGRect(x: x, y: 0, width: label.bounds.width, height: frame.height)
            
            sv.addSubview(label)
            
            x += label.bounds.width
        }
        
        sv.contentSize = CGSize(width: x + margin, height: frame.height)
        
        
        return sv
    }

}

