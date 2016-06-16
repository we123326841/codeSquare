//
//  CardCellView.m
//  Caipiao
//
//  Created by danal-rich on 13-12-2.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "CardCellView.h"

@implementation CardCellView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.backgroundColor = [UIColor whiteColor];
    for (UIView *v in self.subviews){
        v.backgroundColor = self.backgroundColor;
    }
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

+ (NSString *)secrectCard:(NSString *)cardNumber{
    NSMutableString *str = [NSMutableString string];
    NSInteger len = [cardNumber length] - 4;
    for (int i = 0; i < 6; i++) {
        [str appendString:@"*"];
    }
    [str appendString:[cardNumber substringFromIndex:len]];
    return str;
}
@end
