//
//  MyViewController.m
//  Swift大测试4
//
//  Created by 王浩 on 16/4/18.
//  Copyright © 2016年 cc. All rights reserved.
//

#import "MyViewController.h"
#import "Str.h"
@interface MyViewController ()

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   Str *s = [[Str alloc] initWithStr:@"NIMA"];
    NSLog(@"%@",s.str);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
