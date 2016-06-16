//
//  TabBarView.h
//  Caipiao
//
//  Created by 王浩 on 15/10/16.
//  Copyright © 2015年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol TabBarViewDelegate<NSObject>
-(void)tabBarViewBtnClick:(UIButton*)btn;
@end
@interface TabBarView : UIView

@property(nonatomic,weak)id<TabBarViewDelegate>delegate;
@property(nonatomic,weak)UIButton *register1;

@end
