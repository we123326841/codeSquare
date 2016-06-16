//
//  IntroView.h
//  Caipiao
//
//  Created by danal on 13-4-15.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageControl.h"

typedef void(^CompletionBlock)();

@interface IntroView : UIView <UIScrollViewDelegate>
{
    UIScrollView *_scroll;
    PageControl *_pageControl;
}
@property (strong, nonatomic) NSArray *imageFiles;
@property (copy, nonatomic) CompletionBlock comblock;
- (void)setImages:(NSArray *)imageFiles;

@end
