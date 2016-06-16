//
//  LotteryPublicCell.m
//  Caipiao
//
//  Created by rod on 13/1/11.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "LotteryPublicCell.h"

#define BALL_SELECTED(i) [NSString stringWithFormat:@"ball_%d_selected.png", i]
#define WHITE_BALL(i) [NSString stringWithFormat:@"whiteball_%d.png", i]

@implementation LotteryPublicCell
@synthesize lblPeriodNumber;
@synthesize lblOpenDateTime;
@synthesize imageView;
@synthesize row;

- (void)dealloc{
    [_balls release];   _balls = nil;
    [super dealloc];
}

/*
- (void)awakeFromNib{
    _balls = [[NSMutableArray alloc] init];
    float startIndex = 140.f;
    float width = 28;
    float height = 28;
    for(int i = 0; i < 5; i++)
    {
        NSString* imageName = WHITE_BALL(i);
        
        float x = startIndex + (i* (width + 3.f));
        UIImage *image = [UIImage imageNamed:imageName];
        UIImageView* ball = [[UIImageView alloc] initWithImage:image];
        ball.tag = i;
        ball.frame = CGRectMake(x, 8.f, width, height);
        [self.contentView addSubview:ball];
        [_balls addObject:ball];
        [ball release];
    }
}

*/

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _balls = [[NSMutableArray alloc] init];
        float startIndex = 140.f;
        float width = 28;
        float height = 28;
        for(int i = 0; i < 5; i++)
        {
            NSString* imageName = WHITE_BALL(i);
            
            float x = startIndex + (i* (width + 3.f));
            UIImage *image = [UIImage imageNamed:imageName];
            UIImageView* ball = [[UIImageView alloc] initWithImage:image];
            ball.tag = i;
            ball.frame = CGRectMake(x, 8.f, width, height);
            [self.contentView addSubview:ball];
            [_balls addObject:ball];
            [ball release];
        }
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//隐藏datetime area
- (void)layoutSubviews{
    [super layoutSubviews];
    lblOpenDateTime.hidden = YES;
    CGRect rect = lblPeriodNumber.frame;
    rect.origin.y = (self.bounds.size.height - rect.size.height)/2;
    lblPeriodNumber.frame = rect;
}

- (void)setRow:(int)row_{
    [super setRow:row_];
    if (row_ == 0) {
        for (int i = 0; i < [_balls count]; i++) {
            UIImageView *ball = [_balls objectAtIndex:i];
            ball.image = [UIImage imageNamed:BALL_SELECTED(i)];
        }
    }
    else {
        for (int i = 0; i < [_balls count]; i++) {
            UIImageView *ball = [_balls objectAtIndex:i];
            ball.image = [UIImage imageNamed:WHITE_BALL(i)];
        }
    }
}

@end
