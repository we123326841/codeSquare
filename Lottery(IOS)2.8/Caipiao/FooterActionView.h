//
//  FooterActionView.h
//  Caipiao
//
//  Created by danal on 13-1-5.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IconTextButton.h"

#define kIdentifierLeft 10000
#define kIdentifierMiddle 20000
#define kIdentifierRight 30000

@interface FooterActionView : UIView
{
    UIView *_bgView;
}
@property (strong, nonatomic) UIView *leftView;
@property (strong, nonatomic) UIView *middleView;
@property (strong, nonatomic) UIView *rightView;
@end
