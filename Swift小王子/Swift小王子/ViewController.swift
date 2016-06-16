//
//  ViewController.swift
//  Swift小王子
//
//  Created by 王浩 on 16/4/22.
//  Copyright © 2016年 cc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //http://www.jianshu.com/p/072bbc1e4c33
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    
    
    
    func request(){
        //        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://blog.cnrainbird.com"]
        //            cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
        //            timeoutInterval:3];
        //
        //        [NSURLConnection sendSynchronousRequest:request
        //            returningResponse:nil
        //            error:nil];
        //
        //        NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        //        for (NSHTTPCookie *cookie in [cookieJar cookies]) {
        //            NSLog(@"%@", cookie);
        //        }
        
        let request = NSURLRequest(URL: NSURL(string: "http://blog.cnrainbird.com")!, cachePolicy:.ReloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 3)
        do{
            try  NSURLConnection.sendSynchronousRequest(request, returningResponse: nil)
            
            let cookieJar = NSHTTPCookieStorage.sharedHTTPCookieStorage()
            for cookie in cookieJar.cookies! {
                print(cookie)
            }
        }catch{
            print(error)
        }
        
        
        
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
            request()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

