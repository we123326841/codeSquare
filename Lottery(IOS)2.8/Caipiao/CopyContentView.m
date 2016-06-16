//
//  CopyContentView.m
//  Caipiao
//
//  Created by 王浩 on 15/10/19.
//  Copyright © 2015年 yz. All rights reserved.
//

#import "CopyContentView.h"

@implementation CopyContentView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)click:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(CopyViewSubViewClick:)]) {
        [self.delegate CopyViewSubViewClick:sender];
    }
    [self.superview removeFromSuperview];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"呵呵");
}


@end
