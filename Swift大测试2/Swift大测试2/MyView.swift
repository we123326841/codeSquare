//
//  MyView.swift
//  Swift大测试2
//
//  Created by 王浩 on 16/4/18.
//  Copyright © 2016年 cc. All rights reserved.
//

import UIKit

class MyView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    override var frame: CGRect{
       
        willSet{
            
            print("start=\(frame)  after=\(newValue)")
            
            
        }
        
    }
    
    
    override init(frame: CGRect) {
        //super.init(frame: frame)
        super.init(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
