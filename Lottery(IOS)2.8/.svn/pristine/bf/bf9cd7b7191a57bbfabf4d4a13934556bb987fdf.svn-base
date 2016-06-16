//
//  ContentCenterView.m
//  Caipiao
//
//  Created by 王浩 on 15/10/16.
//  Copyright © 2015年 yz. All rights reserved.
//

#import "ContentCenterView.h"

@implementation ContentCenterView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)click:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(centViewSubViewClick:)]) {
        [self.delegate centViewSubViewClick:sender];
    }
    
    [self.superview removeFromSuperview];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"呵呵");
}

@end
