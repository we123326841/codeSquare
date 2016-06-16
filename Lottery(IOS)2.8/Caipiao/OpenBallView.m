//
//  OpenBallView.m
//  Caipiao
//
//  Created by danal-rich on 7/22/14.
//  Copyright (c) 2014 yz. All rights reserved.
//

#import "OpenBallView.h"
#import "Ball.h"

@implementation OpenBallView

- (void)dealloc{
    self.lotteryName = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)updateCodes:(NSString *)codes{
    for (UIView *v in self.subviews){
        [v removeFromSuperview];
    }
    
    NSArray *numbers = [codes publicSplit];
    Echo(@"Update last open codes: %@",numbers);
    CGFloat mar = 5.f, w = (self.bounds.size.width - (numbers.count+1)*mar)/numbers.count;
    w = MIN(32.f, kStandardBallWidth), mar = (self.bounds.size.width - numbers.count*w)/(numbers.count+1);
    for (NSInteger i = 0; i < numbers.count; i++) {
        BallItem *item = [[BallItem alloc] initWithStyle:kBallStyleDefault text:numbers[i] value:@""];
        NSString *classStr = @"Ball";
        if (_isShuangSeQiu) {
            if (i<numbers.count-1) {
                classStr = @"RedBall";
            }else   classStr = @"BlueBall";
        }
        
        Ball *ball = [[NSClassFromString(classStr) alloc] initWithFrame:CGRectMake(mar+i*(w+mar), (self.bounds.size.height-w)/2, w, w) ballItem:item];
        if ([self.lotteryName isEqualToString:JSK3]) {
            NSString *number = numbers[i];
            NSString *imagename = [NSString stringWithFormat:@"sz%ld.png",(long)[number integerValue]];
            UIImage *i = ResImage(imagename);
            ball.normalImage = i;
            ball.selectedImage = i;
            ball.textLbl.text = @"";
            ball.imageView.image = i;
        }
        ball.selected = YES;
        ball.userInteractionEnabled = NO;
        ball.textLbl.font = [UIFont fontWithName:kFontProximaNovaBold size:w/kStandardBallWidth*ball.textLbl.font.pointSize];
        [self addSubview:ball];
        [item release];
        [ball release];
    }
}

@end
