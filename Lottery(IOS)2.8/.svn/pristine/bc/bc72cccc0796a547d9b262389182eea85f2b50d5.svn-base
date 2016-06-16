//
//  GallaryView.h
//  
//
//  Created by danal.luo on 5/26/14.
//  Copyright (c) 2014 danal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSGallaryView : UIControl <UIScrollViewDelegate>
@property (assign, nonatomic) UIScrollView *scroll;
@property (assign, nonatomic) UIPageControl *pageControl;
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) NSArray *items;
@property (assign, nonatomic) CGFloat timeInterval;
@property (assign, nonatomic) NSInteger clickedItemIndex;

/* Update display */
- (void)update;
@end

/* MSGallaryItem  */
@interface MSGallaryItem : NSObject
@property (strong, nonatomic) UIImage *image;
@property (copy, nonatomic) NSString *imageUrl;
@property (copy, nonatomic) NSString *jumpLink;

+ (id)itemWithImage:(UIImage *)image url:(NSString *)imageUrl jumpLink:(NSString *)jumpLink;
@end
