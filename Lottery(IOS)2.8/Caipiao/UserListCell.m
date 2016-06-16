//
//  UserListCell.m
//  Caipiao
//
//  Created by 王浩 on 15/11/9.
//  Copyright © 2015年 yz. All rights reserved.
//

#import "UserListCell.h"

@implementation UserListCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(UserListModel *)model{
    _sequenceLabel.text =model.sequence;
    _nameLabel.text =model.name;

}
@end
