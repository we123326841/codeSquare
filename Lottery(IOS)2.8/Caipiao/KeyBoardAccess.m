//
//  KeyBoardAccess.m
//  Caipiao
//
//  Created by 王浩 on 15/11/19.
//  Copyright © 2015年 yz. All rights reserved.
//

#import "KeyBoardAccess.h"

@implementation KeyBoardAccess
+(instancetype)keyBoard{
    return  [[[NSBundle mainBundle]loadNibNamed:@"KeyBoardAccess" owner:nil options:nil]lastObject];
    

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)subBtn:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(keyBoardAccess:DidSubBtnClick:)]) {
        [self.delegate keyBoardAccess:self DidSubBtnClick:sender];
    }
    
}
- (IBAction)addBtn:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(keyBoardAccess:DidAddBtnClick:)]) {
        [self.delegate keyBoardAccess:self DidAddBtnClick:sender];
    }
}



@end
