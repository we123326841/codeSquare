//
//  ViewController.swift
//  Swift大测试2
//
//  Created by 王浩 on 16/4/8.
//  Copyright © 2016年 cc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    private static let name = "identify"
    
    var count:Int = {
        print("懒加载吗?")
        return 21
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
     // self.demo3()
//        demo4()
//        demo5()
//        demo6()
//        demo7()
//           demo8()
      //  demo9()
       // demo10()
      //  demo12()
        demo13()
        
        
    }
    
//    func demo1(){
//        let a:Int! = nil
//        a //不会崩
//        print(a)//会崩
//        
//        let b:Int? = nil
//        // b! //会崩
//        print(b!) //会崩
//    }
//    
//    
//    func demo2(){
//      // let p = Person(name: "历史")
//       // print(p.name)
//        
//       // let p:Person? = nil
//       // print(p!.name) 会崩
//        
//        
//        let d:Person! = nil
//      //  print(d.name) 会崩
//    }
//    
//    func demo3() {
//      let p = Person(namee: "age", agee: 101)
//       // print(p!.name)
//        
//        let g:Person = p!
//        print(g)
//        
//        
//    }
//    
//    func demo4(){
//       let p = Person(name: "dede", age: 12)
//        
//        let s = Student(name: "DEDE", age: 31)
//       // print(p is Student) false
//      //  print(s is Person) true
//    }
//    
//    func demo5(){
//        let p:Person = Student(name: "浩浩", age: 27)
//       let h = p as! Student
//        print(h)
//    }
//    
//    func demo6(){
//       let s = Student(name: "滚蛋", age: 14)
//        print("start")
//        s.title = "搞蝻子"
//        print("end")
//        print(s.title)
//    }
//    
//    func demo7(){
//       let s = Student(name: "哈韩", age: 12)
//        print("start")
////        s.xiongWei = "胸围耶"
////        print("end1")
////        print(s.xiongWei)
//        s.title = "安徽";
//        
//         print("end1")
//        print(s.title)
//    }
//    
//    func demo8(){
//          let p =  Student(name: "小明", age: 21)
//            print(p.name)
//        
//        print(p.name)
//        
//        
//        print(p.name)
//        
//        p.name = "鸡巴"
//        p.name = "蝻子"
//        
//        print(p.name)
//        
//        
//        print("name1\(p.name1())")
//    }
//    
//    func demo9(){
//       let myView = MyView(frame: CGRect(x: 50  , y: 50, width:100 , height:100))
//        myView.backgroundColor = UIColor.redColor()
//        view.addSubview(myView)
//        UIView.animateWithDuration(3, animations: { 
//       
//                
//                myView.frame = CGRect(x: 100, y: 50, width: 100, height: 100)
//            
//
//            }) { (fin) in
//              
//        }
//        
//        
//    }
    
    
    func demo10(){
     //   let p:Student  = Student(name: "积极", age: 13)
       // p.showMe()
        
    }
    
//    
//    UIView.animateWithDuration(0.4, animations: { () -> Void in
//    tmpSelf!.frame.size.width = tmpSelf!.viewWidth * 0.6
//    
//    }) { (finish) -> Void in
//    
//    let time = dispatch_time(DISPATCH_TIME_NOW,Int64(0.4 * Double(NSEC_PER_SEC)))
//    dispatch_after(time, dispatch_get_main_queue(), { () -> Void in
//    UIView.animateWithDuration(0.3, animations: { () -> Void in
//    tmpSelf!.frame.size.width = tmpSelf!.viewWidth * 0.8
//    })
//    })
    
    
    func demo11() {
       let v = MyView(frame: CGRect(x: 50, y: 50, width: 100, height: 100))
        v.backgroundColor = UIColor.redColor()
        view.addSubview(v)
        UIView.animateWithDuration(2, animations: {
            print("开始")
            //NSThread .sleepForTimeInterval(3)
            print("搞么比")
            v.frame = CGRect(x: 100, y: 50, width: 100, height: 100)
            }, completion: { (finish) in
                print("完成")
                
        })
    }
    
    func demo12() {
       let t = Test(age: 32)
        print(t.age)
        
    }
    
    func demo13() {
        Test.NAAN()
    }

    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //demo9()
        //demo11()
        let s = count
        print(s)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

