//
//  ViewController.swift
//  Swift大测试3
//
//  Created by 王浩 on 16/4/8.
//  Copyright © 2016年 cc. All rights reserved.
//

import UIKit

class ViewController: UITableViewController,UIAlertViewDelegate{
//       lazy var datas = ["北京","上海","天津","澳门","香港","湖北","深圳","云南","马尼拉","台湾","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1"]
    
//    lazy var dataList:[String]? = {
//        print("我在懒加载吗?")
//        return ["张三","李四"]
//    }()
    
    //http://www.jianshu.com/p/9241a578b137
    lazy var datas:[String] = { () ->[String] in
        var arrayM:[String] = [String]()
        for i in 0..<16{
          arrayM.append("城市:\(i)")
           // print(i)
    
        }
        
        return arrayM
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
      //  var arrayM = [String]()
        
//        for i in 0..<16{
//            //  arrayM.append("\(i)")
//            print(i)
//            arrayM.append("21")
//        }
            initLeftBarButton()
            initRightBarButon()
        
    }
    func initLeftBarButton() {
        let leftBtn = UIBarButtonItem(title: "edit", style:UIBarButtonItemStyle.Done, target:self, action: #selector(leftBarButtonClick))
        
        navigationItem.leftBarButtonItem = leftBtn
        navigationItem.leftBarButtonItem?.tintColor = UIColor.redColor()
    }
    
    
       func initRightBarButon(){
        let rightBtn = UIBarButtonItem(title: "Add", style:UIBarButtonItemStyle.Done, target:self, action: #selector(rightBarButtonClick))
        
        navigationItem.rightBarButtonItem = rightBtn
    }
    
    
    func leftBarButtonClick(){
        print("leftBtnClick")
        if navigationItem.leftBarButtonItem?.title == "done" {
            navigationItem.leftBarButtonItem?.title = "edit"
             navigationItem.rightBarButtonItem?.enabled = true
            tableView.setEditing(false, animated: true)
        }else {
            navigationItem.leftBarButtonItem?.title = "done"
            navigationItem.rightBarButtonItem?.enabled = false
            tableView.setEditing(true, animated: true)

        }
    }
    
    func rightBarButtonClick(){
        print("rightBtnClick")
        datas.append("城市:上海")
        tableView.reloadData()
        scrollToBottom()
    }

   
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // print("开始")
            return datas.count
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell   = tableView.dequeueReusableCellWithIdentifier("mycell")
       // print(cell)
       let row = indexPath.row
        cell?.textLabel?.text = datas[row]
        cell?.imageView?.image = UIImage(named: "green.png")
        cell?.detailTextLabel?.text = "呵呵"
        return cell!
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
       let alertView = UIAlertView(title: "被点击的是第\(indexPath.row)行", message: "真是小幸运呢!", delegate: self, cancelButtonTitle: "确定")
        alertView.show()
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        datas.removeAtIndex(indexPath.row)
        let indexPath = NSIndexPath(forRow: indexPath.row, inSection: 0)
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Top)
    }
    
    func scrollToBottom(){
        tableView.scrollToRowAtIndexPath( NSIndexPath(forRow: datas.count-1, inSection: 0), atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
    }
    
    func alertViewCancel(alertView: UIAlertView) {
        print("取消取消....")
    }
    
    override func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        performSegueWithIdentifier("xunhuan", sender: nil)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       let vc = segue.destinationViewController
          let fVC = vc as! FirstViewController
        fVC.titleName = "撕逼"
        
        fVC.delegate = self
    }
    
    
}

extension ViewController :DataSourceValueDelegate{
    func dataChange(vc: FirstViewController, datas: [String]?) {
        self.datas = datas!
        tableView.reloadData()
    }


}

