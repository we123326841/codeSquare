//
//  GreenOddEvenCell.m
//  Caipiao
//
//  Created by Cyrus on 13-6-14.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "GreenOddEvenCell.h"

@interface GreenOddEvenCell ()
@property (copy, nonatomic) NSString *reuseIdentifier;

@end
@implementation GreenOddEvenCell
@synthesize row = _row;
@synthesize pos = _pos;
@synthesize reuseIdentifier = _reuseIdentifier;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
    }
    return self;
}

- (void)setIdentifier:(NSString *)identifier{
    self.reuseIdentifier = identifier;
}

- (void)layoutSubviews{
    
    if (_row%2 == 0){
        _pos = kCellPositionEven;
    }else {
        _pos = kCellPositionOdd;
    }
    
    switch (_pos) {
        case kCellPositionEven:
            self.backgroundColor = [UIColor rgbColorWithHex:@"02361F"];
            break;
        case kCellPositionOdd:
            self.backgroundColor = [UIColor rgbColorWithHex:@"033A22"];
            break;
        default:
            break;
    }
    [super layoutSubviews];
}

@end
