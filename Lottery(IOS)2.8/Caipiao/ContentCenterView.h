//
//  ContentCenterView.h
//  Caipiao
//
//  Created by 王浩 on 15/10/16.
//  Copyright © 2015年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ContentCenterViewDelegate<NSObject>

-(void)centViewSubViewClick:(UIButton*)btn;
@end
@interface ContentCenterView : UIView
@property(nonatomic,assign)id<ContentCenterViewDelegate>delegate;
@end
