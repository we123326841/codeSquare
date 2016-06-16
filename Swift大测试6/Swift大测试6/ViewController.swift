//
//  ViewController.swift
//  Swift大测试6
//
//  Created by 王浩 on 16/4/12.
//  Copyright © 2016年 cc. All rights reserved.
//

enum ViewControllerType:Int {
    case RedType = 0
    case BlueType
    case YellowType
    
    
}

class ViewController: UIViewController {
    weak var vc1:UIViewController?
    weak var vc2:UIViewController?
    weak var vc3:UIViewController?
    var lastVc:UIViewController?
    var tabBar:WHTabBarView?
    var s:Student?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(createSubView()!)
        let vcOne = UIViewController()
        vcOne.view.backgroundColor = UIColor.redColor()
        vc1 = vcOne
        
        let vcTwo = UIViewController()
        vcTwo.view.backgroundColor = UIColor.blueColor()
        vc2 = vcTwo
        
        
        let vcThree = UIViewController()
        vcThree.view.backgroundColor = UIColor.yellowColor()
        vc3 = vcThree
        addChildViewController(vc1!)
        addChildViewController(vc2!)
        addChildViewController(vc3!)
        
    }
    
    func createSubView() -> UIView? {
        tabBar = WHTabBarView(bgColor: UIColor.blackColor(),frame:CGRect(x:0, y:64, width:view.bounds.width,height:  44))
        
        
        let count = 3
        for index in 0..<count {
            
            
            let btnWidth = Double(tabBar!.bounds.size.width) / Double(count)
            let btn = UIButton(frame: CGRect(x:Double(index)*btnWidth , y:0 , width: btnWidth, height: Double(tabBar!.bounds.size.height)))
            btn.setTitle("选项\(index)", forState: .Normal)
            btn.setTitle("选项点击", forState: .Highlighted)
            btn.setTitleColor(UIColor.redColor(), forState: .Normal)
            btn.setTitleColor(UIColor.whiteColor(), forState: .Highlighted)
            btn.tag = index
            //btn.backgroundColor = UIColor.blueColor()
            
            tabBar!.addSubview(btn)
            btn.addTarget(self, action: "btnclick:", forControlEvents: .TouchUpInside)
        }
        return tabBar
    }
    
    func switchSubController(vc:UIViewController){
        lastVc?.view.removeFromSuperview()
        
        
        
        
        view.insertSubview(vc.view, belowSubview: tabBar!)
        
        lastVc = vc
    }
    
    func btnclick(btn:UIButton){
        switch btn.tag {
        case ViewControllerType.RedType.rawValue:
            switchSubController(vc1!)
        case ViewControllerType.BlueType.rawValue:
            switchSubController(vc2!)
        case ViewControllerType.YellowType.rawValue:
            
            switchSubController(vc3!)
        default:
            print("其他")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit{
        print("拜拜..")
    }
}

