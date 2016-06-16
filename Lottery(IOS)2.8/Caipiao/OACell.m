//
//  OACell.m
//  Caipiao
//
//  Created by GroupRich on 15/7/31.
//  Copyright (c) 2015年 yz. All rights reserved.
//

#import "OACell.h"

@implementation OACell

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)dealloc {
    [_contentLabelView release];
    [super dealloc];
}
@end
