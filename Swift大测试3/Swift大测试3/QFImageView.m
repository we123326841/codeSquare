//
//  QFImageView.m
//  Swift大测试3
//
//  Created by 王浩 on 16/4/8.
//  Copyright © 2016年 cc. All rights reserved.
//

#import "QFImageView.h"
//swift代码—>产生了oc的类  swift先编译成 ->oc的代码
#import "Swift大测试3-Swift.h"
@implementation QFImageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)addTarget:(id)target withSel:(SEL)sel{
    _target =target;
    _sel = sel;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
   TestClass *testClass= [[TestClass alloc] init];
    [testClass someFuc];
    NSString * str=[testClass someFuc1:31 y:@"鸡巴"];
    NSLog(@"%@",str);
     NSString * str1=[testClass someFuc2WithShuzi:21 zifuchuan:@"忽忽"];
    NSLog(@"%@",str1);
    [_target performSelector:_sel withObject:self];
}

-(void)textaaa{
    NSLog(@"texttext");
}

-(NSString *)getMyValue{
    return  @"王浩";
}
@end
