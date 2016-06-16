//
//  TransferAlert.m
//  Caipiao
//
//  Created by GroupRich on 14-10-28.
//  Copyright (c) 2014年 yz. All rights reserved.
//

#import "TransferAlert.h"

@implementation TransferAlert

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
-(void)dealloc
{
    self.clickedBlock=nil;
    [super dealloc];
}
- (IBAction)ikonw:(id)sender
{
    _clickedBlock();
}
@end
