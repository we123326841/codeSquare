//
//  BaseChaseViewCell.m
//  ZhuihaoDemo
//
//  Created by 王浩 on 15/11/30.
//  Copyright © 2015年 王浩. All rights reserved.
//

#import "BaseChaseViewCell.h"

@implementation BaseChaseViewCell

- (void)awakeFromNib {
    // Initialization code
    _switchView.tintColor =Color(@"OALeftColor");
    _switchView.onTintColor=Color(@"OALeftColor");
//    _switchView.thumbTintColor=Color(@"OALeftColor");
    _numLabel.layer.borderWidth=0.5;
    _numLabel.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    _numLabel1.layer.borderWidth=0.5;
    _numLabel1.layer.borderColor = [[UIColor lightGrayColor] CGColor];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (IBAction)justSwitch:(UISwitch *)sender {
    
}

- (IBAction)addAndSubClick:(UIButton*)sender {
    if (sender.tag==0) {
        NSInteger value=[_numLabel.text integerValue];
        value--;
        if (value<=0) {
            value=1;
        }
        _numLabel.text=[NSString stringWithFormat:@"%ld",(long)value ];
    }else if (sender.tag==1){
        NSInteger value=[_numLabel.text integerValue];
        value++;
        _numLabel.text=[NSString stringWithFormat:@"%ld",(long)value ];
    
    }else if (sender.tag==2){
        NSInteger value=[_numLabel1.text integerValue];
        value--;
        if (value<=0) {
            value=1;
        }
        _numLabel1.text=[NSString stringWithFormat:@"%ld",(long)value ];
    
    }else if (sender.tag==3){
        NSInteger value=[_numLabel1.text integerValue];
        value++;
        _numLabel1.text=[NSString stringWithFormat:@"%ld",(long)value ];
        

    }
}
@end
