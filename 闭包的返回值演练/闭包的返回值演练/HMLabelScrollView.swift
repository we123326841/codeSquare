//
//  HMLabelScrollView.swift
//  闭包的返回值演练
//
//  Created by 王浩 on 16/3/24.
//  Copyright © 2016年 cc. All rights reserved.
//

import UIKit

class HMLabelScrollView: UIScrollView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    //使用纯代码开发的时候 会被调用
    init(frame: CGRect, numberOfLabel:()-> Int,labelOfIndex:(index: Int)->UILabel) {
            super.init(frame: frame)
        
        //1.实例化 scrollView 并且指定大小&位置
//        let sv = UIScrollView(frame: frame)
        backgroundColor = UIColor.lightGrayColor()
        let count = numberOfLabel()
        print("数量:\(count)")
        let margin:CGFloat = 8
        var x = margin
        for i in 0..<count {
            let label = labelOfIndex(index: i)
            
            label.frame = CGRect(x: x, y: 0, width: label.bounds.width, height: frame.height)
            
            addSubview(label)
            
            x += label.bounds.width
        }
        
        contentSize = CGSize(width: x + margin, height: frame.height)
        
       

        
        
        
        
    }

    required init?(coder aDecoder: NSCoder) {
         //storyBoard&&XIB 会调用 直接崩掉
        fatalError("init(coder:) has not been implemented")
    }
}
