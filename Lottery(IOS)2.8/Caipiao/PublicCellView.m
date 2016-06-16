//
//  PublicCellView.m
//  Caipiao
//
//  Created by danal on 13-7-8.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "PublicCellView.h"
#import "PublicBall.h"

#define kBallTagStart 1
#define kBallTagEnd 7

@implementation PublicCellView

- (void)awakeFromNib{
    self.backgroundColor = Color(@"PublicCellBackgroundColor");
    _nameLbl.textColor = Color(@"PublicCellNameColor");
    _issueLbl.textColor = Color(@"PublicCellIssueColor");
    _pre1IssueLbl.textColor = Color(@"PublicCellIssueColor");
    _pre2IssueLbl.textColor = Color(@"PublicCellIssueColor");
    [_betButton setTitleColor:Color(@"PublicCellButtonColor") forState:UIControlStateNormal];
    _betButton.tag=0;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}

- (void)setCodes:(NSString *)codes{
    [_codes release];
    _codes = [codes copy];
    
    BOOL isSSQ = NO;
    if ([codes rangeOfString:@"+"].length > 0) isSSQ = YES;
    codes = [codes stringByReplacingOccurrencesOfString:@"+" withString:@","];
    NSArray *nums = [codes publicSplit];

    int index = 0;
    for (int tag = kBallTagStart; tag <= kBallTagEnd ; tag++) {
        PublicBall *ball = (PublicBall *)[self viewWithTag:tag];
        ball.hidden = YES;
        if (index < [nums count]){
            ball.hidden = NO;
            ball.number = [nums objectAtIndex:index];
            if (isSSQ)
            {
                if (tag != kBallTagEnd) ball.image = ResImage(@"ball_bg_red.png");
                else ball.image = ResImage(@"ball_bg_blue.png");
            }else if([self.nameLbl.text isEqualToString:JSK3])
            {
                NSString *number = [nums objectAtIndex:index];
                NSString *imagename = [NSString stringWithFormat:@"sz%ld.png",(long)[number integerValue]];
                ball.image = ResImage(imagename);
                ball.number = @"";
            }else
            {
                ball.image = ResImage(@"ball_bg.png");
            }
            index++;
        }
    }
}

- (void)setPre1Codes:(NSString *)pre1Codes
{
    [_pre1Codes release];
    _pre1Codes = [pre1Codes copy];
    
    BOOL isSSQ = NO;
    if ([pre1Codes rangeOfString:@"+"].length > 0) isSSQ = YES;
    pre1Codes = [pre1Codes stringByReplacingOccurrencesOfString:@"+" withString:@","];
    NSArray *nums = [pre1Codes publicSplit];
    
    int index = 0;
    for (int tag = 11; tag <= 17 ; tag++) {
        UILabel *ball = (UILabel *)[self viewWithTag:tag];
        ball.hidden = YES;
        if (index < [nums count]){
            ball.hidden = NO;
            ball.text = [nums objectAtIndex:index];
            ball.textColor = Color(@"PublicCellNumberColor");
            index++;
            
            if (isSSQ) {
                if (tag != 17) ball.textColor = Color(@"PublicCellRedNumberColor");
                else ball.textColor = Color(@"PublicCellBlueNumberColor");
            }
        }
    }
}

- (void)setPre2Codes:(NSString *)pre2Codes
{
    [_pre2Codes release];
    _pre2Codes = [pre2Codes copy];
    
    BOOL isSSQ = NO;
    if ([pre2Codes rangeOfString:@"+"].length > 0) isSSQ = YES;
    pre2Codes = [pre2Codes stringByReplacingOccurrencesOfString:@"+" withString:@","];
    NSArray *nums = [pre2Codes publicSplit];
    
    int index = 0;
    for (int tag = 21; tag <= 27 ; tag++) {
        UILabel *ball = (UILabel *)[self viewWithTag:tag];
        ball.hidden = YES;
        if (index < [nums count]){
            ball.hidden = NO;
            ball.text = [nums objectAtIndex:index];
            ball.textColor = Color(@"PublicCellNumberColor");
            index++;
            
            if (isSSQ) {
                if (tag != 27) ball.textColor = Color(@"PublicCellRedNumberColor");
                else ball.textColor = Color(@"PublicCellBlueNumberColor");
            }
        }
    }
}

+ (NSString *)numFormatter:(NSString *)codes
{
    codes = [codes stringByReplacingOccurrencesOfString:@"+" withString:@","];
    NSArray *nums = [codes publicSplit];
    NSMutableString *result = [[NSMutableString alloc] init];
    for (NSString *n in nums) {
        [result appendFormat:@" %@",n];
    }
    return [result autorelease];
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
