//
//  ViewController.swift
//  Swift(大测试)
//
//  Created by 王浩 on 16/3/30.
//  Copyright © 2016年 cc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var label:UILabel?
    var t:DataSource?
    var a:((String) ->Void)
    var b:((Int) ->Void)?
   lazy var c:[String]? = { () ->[String] in
        print("加载了哟....")
        return ["懒加载","普通加载"]
    }()
    //简单的写法
    lazy var array:[String]? = ["得得","dede"]

//    required init?(coder aDecoder: NSCoder) {
//        a = {(x:String) -> Void in
//            print("大大")
//            
//        }
//        super.init(coder: aDecoder)
//    }
    
    required init?(coder aDecoder: NSCoder) {
        a = {(x:String) -> Void in
            print("大大")
        }

        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
     label = UILabel()
        label!.text = "鸡巴"
        label?.frame = CGRect(x: 100, y: 100, width: 50, height: 50);
        label?.backgroundColor = UIColor.redColor()
        view.addSubview(label!)
//        var f:[String]? = { () ->[String] in
//            print("加载你他妈的....")
//            return ["懒加载","普通加载"]
//        }()
        
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
//       let p = Person(x: 100, dict: ["name":"王浩","age":27])
//      
//        p?.title = "文字"
//        p?.name = "我"
//        p?.age = 28
//          print("\(p?.name)----\(p?.age)----\(p?.title)")
        
//       let s = Student(dict: ["name":"学生","age":31])
//        print("\(s.name)----\(s.age)----\(s.title)----\(s.no)")
//        
//        demo { (x, y) -> String in
//            print("\(x).....\(y)")
//            return "哈哈"
//        }
//        
//        a("得得")
//        
//        
//      let p = Pz(str: "得得得")
        //  1.weak var weakSelf = self   2.[weak self] 3.[unowned self]
//        demo1 {[unowned self] (x) in
//            print("\(x).....\(self.view)")
//        }
//        
//        
//        
//       let p = Pz(str: "dede")
        
//        let age = 18
//        
//        assert(age > 100, "不能小于20岁")
//        
//        
//        print("你阿妈的")
        
//        demo3 { (f) -> Int in
//            print("f==\(f)")
//            return 54
//        }
//        
//        func huhuhu(g:String)->Int{
//            print("你他妈的有病啊\(g)")
//            return 43
//        }
//        
//        demo3(huhuhu)
        
     // self.t = DataSource()
//     let t = TestClass()
//    t.title = "的"
//      //  t.title1 = "得得"
//        t.name = "忽忽"
//        print(t.name)
//     let t = TestClass1()
//        t.totalSteps = 9
//        
//        t.totalSteps = 1
        
      let t = TestClass()
        t.name = "3到"
        print(t.name)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func demo(a:((Int,String) ->String)) ->String{
    
        a(12, "你妈的逼,我加载完了")
    
        return "得得得"
    }
    
    func demo1(x:(Int)->Void ){
       b = x
        demo2()
    }
    
    deinit{
        print("拜拜...")
    
    }
    
    func demo2() {
        b?(21)
    }
    
    
    func demo3(x:(String)->Int) {
        print("xxxx=")
        x("allen棒棒哒")
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //print(c)
       // self.t?.d
        label?.text = "积得得极"
        label?.sizeToFit()
    }
    
    
    

}

