//
//  ViewController.m
//  swift(do..catch的使用)
//
//  Created by 王浩 on 16/3/30.
//  Copyright © 2016年 cc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    NSLog(@"你你你..");
    NSError * error = nil;
   NSString *str =@"{\"name\":\"张三\",\"age\":31}";
   NSData *data=[str dataUsingEncoding:NSUTF8StringEncoding];
   id serial = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    if (error) {
        NSLog(@"嘿嘿:%@",error);
    }
    NSLog(@"serial=%@",serial);
    
    
    NSDictionary *dict = @{@"name":@"李四",@"age":@45};
    
    NSLog(@"dict=%@",dict);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
