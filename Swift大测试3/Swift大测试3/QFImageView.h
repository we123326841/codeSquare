//
//  QFImageView.h
//  Swift大测试3
//
//  Created by 王浩 on 16/4/8.
//  Copyright © 2016年 cc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QFImageView : UIImageView
@property(nonatomic,assign)SEL sel;

@property(nonatomic,weak)id target;
-(void)addTarget:(id)target withSel:(SEL)sel;
-(void)textaaa;
-(NSString*)getMyValue;
@end
