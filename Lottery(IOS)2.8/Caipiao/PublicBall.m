//
//  PublicBall.m
//  Caipiao
//
//  Created by danal on 13-7-8.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "PublicBall.h"

@implementation PublicBall

- (void)dealloc{
    [_number release];
    [super dealloc];
}

- (void)awakeFromNib{
    self.contentMode = UIViewContentModeScaleAspectFit;
    self.image = ResImage(@"ball_bg.png");
    
    UIFont *font = [UIFont boldSystemFontOfSize:12.f];
    
    CGRect frame = self.bounds;
    frame.origin.y -= 2;
    _numberImageView = [[UIImageView alloc] initWithFrame:frame];
    _numberImageView.contentMode = UIViewContentModeCenter;
    [self addSubview:_numberImageView];
    
    float x = self.bounds.size.width + 5.f, y = self.bounds.size.height/2;
    float w = [font lineHeight];
    _lbl1 = [[UILabel alloc] initWithFrame:CGRectMake(x, y - w, w, w)];
    _lbl1.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height - 6.f);
    _lbl1.font = [UIFont fontWithName:kFontProximaNovaBold size:17.f];
    _lbl1.shadowColor = [UIColor grayColor];
    //_lbl1.shadowOffset = CGSizeMake(0, 2);
    _lbl1.textAlignment = NSTextAlignmentCenter;
    _lbl1.backgroundColor = [UIColor clearColor];
    _lbl1.textColor = [UIColor whiteColor];
    [self addSubview:_lbl1];
    [_lbl1 release];
    
    _lbl2 = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, w)];
    _lbl2.font = font;
    _lbl2.backgroundColor = [UIColor clearColor];
    _lbl2.textColor = kYellowTextColor;
    [self addSubview:_lbl2];
    [_lbl2 release];
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self awakeFromNib];
    }
    return self;
}

- (void)setNumber:(NSString *)number{
    [_number release];
    _number = [number copy];
    _lbl1.text = number;
//    _numberImageView.image = ResImage([NSString stringWithFormat:@"%@.png",number]);
    
//    _lbl1.text = [number intValue] > 4 ? @"大" : @"小";
//    _lbl2.text = [number intValue] %2 == 0 ? @"双" : @"单";
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end



@implementation Public8Ball

- (void)setNumber:(NSString *)number{
    [super setNumber:number];
    _lbl1.hidden = _lbl2.hidden = YES;
//    _lbl1.text = [number intValue] > 4 ? @"大" : @"小";
//    _lbl2.text = [number intValue] %2 == 0 ? @"双" : @"单";
}


@end


@implementation PublicRedBall

- (void)awakeFromNib{
    [super awakeFromNib];
    self.image = ResImage(@"ball_bg_red.png");
}

- (void)setNumber:(NSString *)number{
    [super setNumber:number];
    _lbl1.hidden = _lbl2.hidden = YES;
}

@end

@implementation PublicBlueBall

- (void)awakeFromNib{
    [super awakeFromNib];
    self.image = ResImage(@"ball_bg_blue.png");
}

- (void)setNumber:(NSString *)number{
    [super setNumber:number];
    _lbl1.hidden = _lbl2.hidden = YES;
}

@end