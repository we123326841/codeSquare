//
//  HallCellView.m
//  Caipiao
//
//  Created by danal on 13-8-27.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "HallCellView.h"
#import "CDLottery.h"
#import "LotteryTimer.h"

@interface HallCellView()
@property (strong, nonatomic) NSTimer *timer;
@end

@implementation HallCellView

- (void)dealloc{
    [self.timer invalidate];
    self.timer = nil;
    self.lottery = nil;
    [super dealloc];
}

- (void)awakeFromNib{
    self.layer.cornerRadius = 3.f;
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.1f];
    self.timeLbl.textColor =
    self.issueLbl.textColor =
    self.titleLbl.textColor = kYellowTextColor;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)timerThread:(NSTimer *)t{
    NSString *str =  [[SimpleLotteryTimer shared] remainningTimeStrForLottery:self.lottery.name];
    if ([self.lottery.paused boolValue]){
        self.timeLbl.text = @"今日投注已截止";
    } else {
        self.timeLbl.text = [NSString stringWithFormat:@"还剩 %@", str];
    }
    self.issueLbl.text = [NSString stringWithFormat:@"第%@期", self.lottery.issue ? self.lottery.issue : @" - "];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.timer invalidate];
    self.timer = nil;
    
    CDLottery *lot = self.lottery;
    self.imageView.image = [UIImage imageNamed:lot.logo];
    self.titleLbl.text = lot.name;
    self.introLbl.text = lot.introduction;
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(timerThread:) userInfo:nil repeats:YES];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark - ColorCell
- (void)onCellHighlighted:(BOOL)highlighted animated:(BOOL)animated{

    if (highlighted) {
        self.accessory.image = [UIImage imageNamed:@"hall_arrow_on"];
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.2f];
    } else {
        self.accessory.image = [UIImage imageNamed:@"hall_arrow"];
        [UIView animateWithDuration:.2f animations:^{
            self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.1f];
        }];
    }
}

@end
