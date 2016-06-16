//
//  ViewController.m
//  跟Swift对比
//
//  Created by 王浩 on 16/3/22.
//  Copyright © 2016年 cc. All rights reserved.
//

#import "ViewController.h"
#import "NSString+Url.h"
#import "Student.h"
#import "FlowLayout.h"
@interface ViewController ()<PersonDataSouceFlow>
@property(nonatomic,strong)UIView *u;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    NSLog(@"%@",[@"JSUXaxL/O34NC97Wwf9x3rxOF0gTnml+0IN8KedEsFq8mOo3bjNfsA==" stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet alphanumericCharacterSet]]);
//    
//    
//    NSLog(@"%@",[@"JSUXaxL/O34NC97Wwf9x3rxOF0gTnml+0IN8KedEsFq8mOo3bjNfsA==" URLEncodedString]);
//    
//    
//    NSLog(@"%@",(NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)@"JSUXaxL/O34NC97Wwf9x3rxOF0gTnml+0IN8KedEsFq8mOo3bjNfsA==%",NULL,NULL,kCFStringEncodingUTF8)));
//
//    
//    
//    
//    NSString *urlString= @"JSUXaxL/O34NC97Wwf9x3rxOF0gTnml+0IN8KedEsFq8mOo3bjNfsA==%";
//                          
//                          NSString * encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)urlString, NULL, NULL,  kCFStringEncodingUTF8 ));
//                          
//    
//    
//    [self loadData];
    
    self.u = [[UIView alloc] init];
    self.u.backgroundColor =[UIColor redColor];
    self.u.frame =CGRectMake(20, 20, 20, 20);
    [self.view addSubview:self.u];
}


-(void)loadData{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"玩命加载中...%@",[NSThread currentThread]);
        dispatch_async(dispatch_get_main_queue(), ^{
              NSLog(@"回调%@",[NSThread currentThread]);
        });
    });

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//func loadData(){
//    
//    dispatch_async(dispatch_get_global_queue(0, 0)) {
//        print("玩命加载中....\(NSThread.currentThread())")
//        
//        dispatch_async(dispatch_get_main_queue(), {
//            print("回调\(NSThread.currentThread())")
//        })
//    }
//    
//    
//}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
  // Person * p = [[Person alloc] init];
//    self.u.frame =CGRectMake(60, 60, 100, 100);
//    [self.view addSubview:self.u];
//    
//    [self performSegueWithIdentifier:@"table" sender:nil];
    Person * p =[[Person alloc] initWithType:[[FlowLayout alloc]init]];
    p.dataSource =self;
   
    [p comeShift];
    
    
}

-(void)personDidDataSource{
    NSLog(@"didDataSource");
}

-(void)personDidDataSourceFlow{
    NSLog(@"didDataSourceFlow");
}

@end
