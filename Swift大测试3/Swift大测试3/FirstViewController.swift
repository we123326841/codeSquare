//
//  FirstViewController.swift
//  Swift大测试3
//
//  Created by 王浩 on 16/4/8.
//  Copyright © 2016年 cc. All rights reserved.
//

import UIKit

protocol DataSourceValueDelegate {
    func dataChange(vc:FirstViewController,datas:[String]?)
}


class FirstViewController: UIViewController {
    lazy var datas:[String] = { () ->[String] in
        var arrayM:[String] = [String]()
    
        for index in 0...90 {
            arrayM.append("我日你妈的:\(index)")
        }
        
        return arrayM
    }()
    
    
    
    var titleName:String?
        var delegate:DataSourceValueDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        print("FirstViewController...\(titleName)")
        // Do any additional setup after loading the view.
        
       let im = UIImage(named: "green.png")
       let qfView = QFImageView(image: im)
        qfView.userInteractionEnabled = true
        
        qfView .addTarget(self, withSel: #selector(FirstViewController.imageClick(_:)))
        view.addSubview(qfView)
        qfView.textaaa()
        let ddd = qfView.getMyValue()
        
    }
    
    func imageClick(sender:AnyObject) {
        print("点击了咧...\(sender)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func backClick(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
        if((self.delegate) != nil){
            self.delegate?.dataChange(self, datas: datas)
        }
        
    }

    deinit{
        print("销毁")
    }
}
