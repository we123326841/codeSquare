//
//  ViewController.swift
//  Swift(循环引用)
//
//  Created by 王浩 on 16/3/29.
//  Copyright © 2016年 cc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //控制器对闭包callBack进行强引用 ==控制器引用闭包callback
    var callBack:((String) ->String)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.redColor()
        // Do any additional setup after loading the view, typically from a nib.
        demo2()
    }
    
    
    
    func demo(){
        
        //解决循环引用方法1
        weak var weakSelf = self//解决循环引用
        loadData { (va) -> String in
            //闭包是准好的代码,必须要使用self 
            //闭包对控制器进行强引用
            print("我他妈的"+va+"\(weakSelf?.view)")
            
            return "呵呵"
        }
        

    }
    
    
    func demo1(){
        //解决循环引用方法2    [weak self]在闭包中  不对self 进行强引用 ,可以随时释放
        loadData {[weak self] (va) -> String in
            //闭包是准好的代码,必须要使用self
            print("我他妈的"+va+"\(self?.view)")
            
            return "呵呵"
        }

    }
    
    
    func demo2(){
        
        //解决循环引用方法3 [unowned self] 会记录self的地址(地址是始终存在的) 但是不会做强引用 ,风险:一旦self真的被释放了 程序会崩溃
                loadData {[unowned self] (va) -> String in
            //闭包是准好的代码,必须要使用self
            print("我他妈的"+va+"\(self.view)")//这里不能用self?.view  因为self 是一定有值的 因为它用的[unowned self] 保证有值
            
            return "呵呵"
        }
        
        
    }


    
    
    func loadData(x:(String) ->String ){
        dispatch_async(dispatch_get_global_queue(0, 0)) { 
            print("耗时加载中...")
            dispatch_sync(dispatch_get_main_queue(), { 
                self.callBack = x
                self.xixi()
//                x("得得")
//                self.xixi()
            })
        }
    }
    
    
    
    func xixi(){
        print(callBack)
        callBack!("加载了哟哟哟")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit{
        print("拜拜")
    }


}

