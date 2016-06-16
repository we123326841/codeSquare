//
//  SwiftViewController.swift
//  swift(do..catch的使用)
//
//  Created by 王浩 on 16/3/30.
//  Copyright © 2016年 cc. All rights reserved.
//

import UIKit

class SwiftViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        // Do any additional setup after loading the view.
        //        print("hellow")
        //       let url = NSURL(string: "http://www.weather.com.cn/data/sk/101010100.html")
        //       NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, _ , _) in
        //          //  print("data=\(data)")
        //            let dataTest = "{\"name\":\"张三\",\"age\":31}"
        //            let dataReal = dataTest.dataUsingEncoding(NSUTF8StringEncoding)
        //            //强行try! 一定要确保json 真的没有问题,,类似于 变量 a! 如果确定执行的代码没问题就写成强行try!   如果不能就 用do catch..
        //          //let jsonStr = try! NSJSONSerialization.JSONObjectWithData(dataReal!, options: [])
        //
        //
        //        //do..catch 可以捕获异常..类似java异常机制
        //
        //        do{
        //        let jsonStr = try NSJSONSerialization.JSONObjectWithData(dataReal!, options: [])
        //            print(jsonStr)
        //            print("继续..")
        //        }catch{
        //            print("error==\(error)")
        //        }
        //
        //        print("end....")
        //
        //        }.resume()
       demo1()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func demo1(){
        let dataTest = "{\"name\":\"张三\",\"age\":31"
        let dataReal = dataTest.dataUsingEncoding(NSUTF8StringEncoding)
        
//        do{
//            let jsonStr = try NSJSONSerialization.JSONObjectWithData(dataReal!, options: [])
//            print("jsonStr\(jsonStr)")
//            print("继续")
//            
//        }catch{
//            print("error:::::\(error)")
//        }
        //要确保NSJSONSerialization.JSONObjectWithData(dataReal!, options: []) 能够正常执行 才用try!  不然就会崩溃
        let jsonStr = try! NSJSONSerialization.JSONObjectWithData(dataReal!, options: [])
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
