//
//  DeleteLinkDialog.m
//  Caipiao
//
//  Created by 王浩 on 15/10/19.
//  Copyright © 2015年 yz. All rights reserved.
//

#import "DeleteLinkDialog.h"

@implementation DeleteLinkDialog

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (IBAction)sure:(id)sender {
    if([self.delegate respondsToSelector:@selector(deleteLink:didBtnClick:)]){
        
        [self.delegate deleteLink:self didBtnClick:DeleteLinkDialogButtonTypeSure];
    }
   
    
    
    [self.superview removeFromSuperview];
}
- (IBAction)cancel:(id)sender {
    if([self.delegate respondsToSelector:@selector(deleteLink:didBtnClick:)]){
        
        [self.delegate deleteLink:self didBtnClick:DeleteLinkDialogButtonTypeCancel];
    }
    

    
    [self.superview removeFromSuperview];

}



@end
