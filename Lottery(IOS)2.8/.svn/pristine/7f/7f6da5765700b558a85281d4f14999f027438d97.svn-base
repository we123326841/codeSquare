//
//  Ball.m
//  Caipiao
//
//  Created by danal on 13-1-5.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "Ball.h"
#import "BallIndicator.h"


#pragma mark - Ball

@interface Ball ()
{
    CGRect _normalFrame;
}
@property (retain, nonatomic) BallIndicator *indicator;
@end

@implementation Ball

- (void)dealloc{
    [_normalImage release];
    [_selectedImage release];
    [_ballItem release];
    self.indicator=nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame ballItem:(BallItem *)item
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.contentMode = UIViewContentModeScaleAspectFit;
        self.userInteractionEnabled = YES;
        self.shouldShowIndicator = YES;
        self.ballItem = item;
        
        CGRect rect = self.bounds;
        _imageView = [[UIImageView alloc] initWithFrame:rect];
        _imageView.backgroundColor = [UIColor clearColor];
        [self addSubview:_imageView];
        
        _textLbl = [[UILabel alloc] initWithFrame:rect];
        _textLbl.textAlignment = UITextAlignmentCenter;
        _textLbl.textColor = [UIColor whiteColor];
        _textLbl.font = [UIFont fontWithName:kFontProximaNovaBold size:20.f];
        _textLbl.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _textLbl.backgroundColor = [UIColor clearColor];
        _textLbl.text = item.text;
        [self addSubview:_textLbl];
        [_textLbl release];
        
        NSString *normalImageName = self.ballItem.style == kBallStyleDefault ? @"ball_bg_normal.png" : @"ball_rounded_normal.png";
        NSString *selectedImageName = self.ballItem.style == kBallStyleDefault ? @"ball_bg.png" : @"ball_rounded.png";
        self.normalImage = ResImage(normalImageName);
        self.selectedImage = ResImage(selectedImageName);
        _normalFrame = _imageView.frame;
    }
    return self;
}

- (void)setSelected:(BOOL)selected{
    _selected = selected;
    [self active:selected];
}

- (void)setImage:(UIImage *)image{
    _imageView.image = image;
}

- (void)active:(BOOL)active{

    if (active) {
        CGRect rect = _normalFrame;
        rect.origin.x -= 2;
//        rect.origin.y -= 2;
        rect.size.width += 4;
        rect.size.height += 8;
        _imageView.frame = rect;
        _textLbl.textColor = [UIColor whiteColor];
        _textLbl.shadowColor = [UIColor grayColor];
        //_textLbl.shadowOffset = CGSizeMake(0, 2);
        UIImage *image = self.selectedImage;
        if (self.ballItem.style == kBallStyleRoundedRect && image.size.width < self.bounds.size.width){
            self.contentMode = UIViewContentModeScaleToFill;
            self.image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(image.size.height/2, image.size.width/2, image.size.height/2, image.size.width/2)];
        } else {
            self.image = image;
        }
    } else {
        _imageView.frame = _normalFrame;
        _textLbl.textColor = Color(@"BetBallNormalColor");
        _textLbl.shadowColor = nil;
        //_textLbl.shadowOffset = CGSizeMake(0, 0);
        UIImage *image = self.normalImage;
        if (self.ballItem.style == kBallStyleRoundedRect && image.size.width < self.bounds.size.width){
            self.contentMode = UIViewContentModeScaleToFill;
            self.image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(image.size.height/2, image.size.width/2, image.size.height/2, image.size.width/2)];
        } else {
            self.image = image;
        }
    }
}

- (BOOL)selected{
    return _selected;
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if (_selected) {    //deselect it
        [self active:NO];
        
    } else if (self.shouldShowIndicator) {            //show the indicator
        BallIndicator *indicator = [BallIndicator indicator];
        CGRect bounds = indicator.bounds;
        float scale = self.bounds.size.width/kStandardBallWidth;
        bounds.size = CGSizeMake(bounds.size.width*scale, bounds.size.height*scale);
        indicator.bounds = bounds;
        [indicator setText:self.ballItem.value];
        [indicator showOnBall:self atPoint:CGPointMake(-3.f*scale, -5.f*scale)];
        self.indicator = indicator;
        //Show to the top view
        UIView *topView = [[[UIApplication sharedApplication] keyWindow].subviews lastObject];
        CGRect rect = [indicator convertRect:indicator.frame toView:topView];
        [topView addSubview:indicator];
        rect.origin.y += 45.f;
        rect.origin.x += 2.f;
        indicator.frame = rect;
        
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{

    _selected = !_selected;
    if (_selected) {
        [self active:YES];
        [self.indicator performSelector:@selector(dismiss) withObject:nil afterDelay:.2f];
    }
    if (self.delegate){
        [self.delegate ballDidClick:self selected:_selected];
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    //remove the indicator
    [self.indicator dismiss];
}

@end


@implementation RedBall

- (id)initWithFrame:(CGRect)frame ballItem:(BallItem *)item{
    self = [super initWithFrame:frame ballItem:item];
    if (self){
        self.normalImage = ResImage(@"ball_bg_normal.png");
        self.selectedImage = ResImage(@"ball_bg_red.png");
    }
    return self;
}

@end

@implementation BlueBall

- (id)initWithFrame:(CGRect)frame ballItem:(BallItem *)item{
    self = [super initWithFrame:frame ballItem:item];
    if (self){
        self.normalImage = ResImage(@"ball_bg_normal.png");
        self.selectedImage = ResImage(@"ball_bg_blue.png");
    }
    return self;
}

@end

@implementation JSKSHZBall

- (id)initWithFrame:(CGRect)frame ballItem:(BallItem *)item{
    self = [super initWithFrame:frame ballItem:item];
    if (self)
    {
        
    }
    return self;
}


@end