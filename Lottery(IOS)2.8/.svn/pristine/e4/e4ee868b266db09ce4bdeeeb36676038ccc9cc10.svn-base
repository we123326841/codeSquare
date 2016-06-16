//
//  CoverView.m
//  Caipiao
//
//  Created by 王浩 on 15/10/16.
//  Copyright © 2015年 yz. All rights reserved.
//

#import "CoverView.h"

@implementation CoverView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
    self.backgroundColor =[UIColor colorWithRed:109/255.0 green:109/255.0 blue:109/255.0 alpha:0.4];
    
    
    }
    
    
    return  self;



}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (!_isDisplay) {
        
        [self dismiss];
    }
    

}


-(void)dismiss{
    
      // self.center.x
    [self removeFromSuperview];
}

-(void)dealloc{
    [super dealloc];
    NSLog(@"coverView is dealloc");

}
@end
