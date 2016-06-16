//
//  ViewController.swift
//  闭包的演练
//
//  Created by 王浩 on 16/3/22.
//  Copyright © 2016年 cc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       // loadData()
        
        //尾随闭包
        //1.闭包是最后一个参数
        //2.函数的()可以提前关闭
        //3.最后一个参数直接使用(代码实现)
        dispatch_async(dispatch_get_main_queue()) { 
            
        }
        //跟上面的是等效的
        dispatch_async(dispatch_get_main_queue(),{
            
        })
        
        dispatch_async(dispatch_get_main_queue()) { 
            
        }
        
        
        
        loadData2({x ->() in
                print(x)
        })
        
        
    }
    
    
    
    func loadData2(finish:(String) ->()){
        dispatch_async(dispatch_get_global_queue(0, 0)) { 
            print("玩命加载中....\(NSThread.currentThread())")
            dispatch_sync(dispatch_get_main_queue(), { 
                print("主线程回调了哟...\(NSThread.currentThread())")
                finish("我他妈完成了..")
            })
        }
        
    
    
    
    }
    
    func loadData(){
    
        dispatch_async(dispatch_get_global_queue(0, 0), {
            print("玩命加载中....\(NSThread.currentThread())")
            
            dispatch_async(dispatch_get_main_queue(), { 
               print("回调\(NSThread.currentThread())")
            })
        })
        
        
    }

   
}

