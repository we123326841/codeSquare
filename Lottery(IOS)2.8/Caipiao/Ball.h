//
//  Ball.h
//  Caipiao
//
//  Created by danal on 13-1-5.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BallItem.h"



@protocol BallDelegate;

@interface Ball : UIView
{
    BOOL _selected;
    UIImageView *_imageView;
}
@property (assign, nonatomic) id<BallDelegate> delegate;
@property (strong, nonatomic) UIImage *normalImage;
@property (strong, nonatomic) UIImage *selectedImage;
@property (nonatomic) BOOL selected;
@property (nonatomic) BOOL shouldShowIndicator;
@property (assign, nonatomic) UILabel *textLbl;
@property (strong, nonatomic) BallItem *ballItem;
@property (strong, nonatomic) UIImageView *imageView;
- (id)initWithFrame:(CGRect)frame ballItem:(BallItem *)item;

@end


@protocol BallDelegate <NSObject>
- (void)ballDidClick:(Ball *)ball selected:(BOOL)selected;

@end


@interface RedBall : Ball

@end

@interface BlueBall : Ball

@end

@interface JSKSHZBall : Ball

@end