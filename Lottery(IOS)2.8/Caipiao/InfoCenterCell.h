//
//  InfoCenterCell.h
//  Caipiao
//
//  Created by rod on 13/1/15.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "BaseCell.h"
#import "RQNotice.h"

@interface TypeLabel : UILabel
@property (strong, nonatomic) UIColor *bgColor;
@end

@interface InfoCenterCell : BaseCell
@property (strong, nonatomic) IBOutlet TypeLabel * lblType;
@property (strong, nonatomic) IBOutlet UILabel * lblContent;
@property (strong, nonatomic) IBOutlet UILabel * lblTitle;
@property (strong, nonatomic) IBOutlet UILabel * lblDateTime;
@property (strong, nonatomic) IBOutlet UIImageView * iconNew;
@property (assign, nonatomic) NoticeType noticeType;
@end
