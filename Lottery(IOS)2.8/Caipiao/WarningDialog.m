//
//  WarningDialog.m
//  Caipiao
//
//  Created by 王浩 on 15/11/13.
//  Copyright © 2015年 yz. All rights reserved.
//

#import "WarningDialog.h"
@interface WarningDialog()

@property (retain, nonatomic) IBOutlet UIView *contentView;

@property (retain, nonatomic) IBOutlet UIButton *checkBox;

@end
@implementation WarningDialog

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)checkBoxClick:(UIButton *)sender {
    sender.selected =!sender.isSelected;
    
    
}

-(void)awakeFromNib{

    self.backgroundColor  =[UIColor colorWithRed:109/255.0 green:109/255.0 blue:109/255.0 alpha:0.4];
    self.contentView.layer.cornerRadius = 10.0f;
    self.contentView.layer.borderColor = [UIColor colorWithWhite:0.9 alpha:0.9].CGColor;
    self.contentView.layer.borderWidth = 2.0f;
    [self.checkBox setAdjustsImageWhenHighlighted:NO];


}

+(instancetype)warningWithNib{
   return  [[[NSBundle mainBundle] loadNibNamed:@"WarningDialog" owner:nil options:nil]firstObject];


}

- (IBAction)hide:(id)sender {
    CAKeyframeAnimation *hideAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    hideAnimation.duration = 0.4;
    hideAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
                             [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0f, 1.0f, 1.0f)],
                             [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.00f, 0.00f, 0.00f)]];
    hideAnimation.keyTimes = @[@0.2f, @0.5f, @0.75f];
    hideAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                      [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                      [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    hideAnimation.delegate = self;
    [self.layer addAnimation:hideAnimation forKey:nil];
   
             //1.获取NSUserDefaults对象
             NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
      
           //2保存数据(如果设置数据之后没有同步, 会在将来某一时间点自动将数据保存到Preferences文件夹下面)
             [defaults setBool:self.checkBox.isSelected forKey:@"isNeedTip"];
      //3.强制让数据立刻保存
      [defaults synchronize];
    
    
    
    
}


-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [self removeFromSuperview];
    
}


@end
