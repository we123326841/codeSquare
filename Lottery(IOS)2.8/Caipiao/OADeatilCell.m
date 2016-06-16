//
//  OADeatilCell.m
//  Caipiao
//
//  Created by GroupRich on 15/8/2.
//  Copyright (c) 2015年 yz. All rights reserved.
//

#import "OADeatilCell.h"
#import "OADeatilView.h"
#import "RQOpenLinkDetail.h"
#import "RQManualSetting.h"
#import "CoverView.h"
#import "RebateDialog.h"
@interface UIView (Frame)
- (CGFloat)y;
- (void)setY:(CGFloat)newY;
- (CGFloat)x;
- (void)setX:(CGFloat)newX;
- (CGFloat)h;
- (void)setH:(CGFloat)newH;
@end
@implementation UIView(Frame)
-(CGFloat)y
{
    return self.frame.origin.y;
}
-(void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
- (CGFloat)x
{
    return self.frame.origin.x;

}
- (void)setX:(CGFloat)newX
{
    CGRect frame = self.frame;
    frame.origin.x = newX;
    self.frame = frame;
}
- (CGFloat)h
{
    return self.frame.size.height;
    
}
- (void)setH:(CGFloat)newH
{
    CGRect frame = self.frame;
    frame.size.height = newH;
    self.frame = frame;
}
@end

@interface OADeatilCell ()
@property(nonatomic,retain)CoverView*cover;
@end


@implementation OADeatilCell

-(void)setObjects:(NSArray *)objects
{
    [_objects release];
    _objects = [objects copy];
    [self setUpSubview];
}
-(void)setObjects:(NSArray *)objects fromClass:(UIViewController*)vc{
    [_objects release];
    _objects = [objects copy];
    [self setUpSubview:vc];

}



-(void)setObjectsforManual:(NSArray *)objects{
    [_objects release];
    _objects = [objects retain];
    [self setUpSubviewforManual];
    
}

-(void)setUpSubviewforManual{
    [self.contentView.subviews enumerateObjectsUsingBlock:^(UIView* obj, NSUInteger idx, BOOL *stop) {
        if (obj.tag==100) {
            [obj performSelector:@selector(removeFromSuperview)];
        }
    }];
    UserAwardList *o = _objects.firstObject;
    self.title.text = o.lotteryName;
    
    __block CGFloat x=0,y=45;
    
    [_objects enumerateObjectsUsingBlock:^(UserAwardList* obj, NSUInteger idx, BOOL *stop) {
        
        UIView *v = [OADeatilView oadetailviewwithobjectForManaul:obj];
        if ([v isKindOfClass:[OADeatilViewOne class]]) {
            OADeatilViewOne *one=(OADeatilViewOne *)v;
            one.listObj =obj;
            one.cell =self;
            one.radioBtn.selected=obj.isSelected;
            if (obj.manualType==ManualSettingTypeAgent) {
                
                [one.radioBtn setImage:ResImage(@"checkon.png") forState:UIControlStateSelected];
            }

          //  one.radioBtn.hidden=YES;
            // obj.radioBtn =one.radioBtn;
        }else if ([v isKindOfClass:[OADeatilViewTwo class]]){
            OADeatilViewTwo*two=(OADeatilViewTwo *)v;
            //two.radioBtn.hidden=YES;
             two.listObj=obj;
            two.cell =self;

            two.radioBtn.selected=obj.isSelected;
            two.isSelected =obj.isSelected;
            if (obj.manualType ==ManualSettingTypeAgent) {
                
                [two.radioBtn setImage:ResImage(@"checkon.png") forState:UIControlStateSelected];
            }

            // obj.radioBtn=two.radioBtn;
        }
        
        
        
        
        
        v.tag = 100;
        UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ActiondoForManual:)];
        
        [v addGestureRecognizer:tapGesture];
        [self.contentView addSubview:v];
        v.x = x;
        v.y = y;
        //v.backgroundColor=[UIColor yellowColor];
        y += (v.h+5);
        if (idx<_objects.count-1)
        {
            UIImageView *line = [self line];
            line.tag=100;
            [self.contentView addSubview:line];
            //self.contentView.backgroundColor=[UIColor greenColor];
            line.y = y;
            
            y += (line.h+5);
        }
    }];


}


-(void)setUpSubview
{
    
    [self.contentView.subviews enumerateObjectsUsingBlock:^(UIView* obj, NSUInteger idx, BOOL *stop) {
        if (obj.tag==100) {
            [obj performSelector:@selector(removeFromSuperview)];
        }
    }];
    OpenLinkDetailObject *o = _objects.firstObject;
    self.title.text = o.lot_name;
    
    __block CGFloat x=0,y=45;
    
    [_objects enumerateObjectsUsingBlock:^(OpenLinkDetailObject* obj, NSUInteger idx, BOOL *stop) {
        
        UIView *v = [OADeatilView oadetailviewwithobject:obj];
        if ([v isKindOfClass:[OADeatilViewOne class]]) {
            OADeatilViewOne *one=(OADeatilViewOne *)v;
            one.radioBtn.hidden=YES;
            // one.obj =obj;
            // obj.radioBtn =one.radioBtn;
        }else if ([v isKindOfClass:[OADeatilViewTwo class]]){
            OADeatilViewTwo*two=(OADeatilViewTwo *)v;
            two.radioBtn.hidden=YES;
            // two.obj=obj;
            // obj.radioBtn=two.radioBtn;
        }

        
        
        
        
        v.tag = 100;
       // UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Actiondo:)];
        
       // [v addGestureRecognizer:tapGesture];
        
        [self.contentView addSubview:v];
        v.x = x;
        v.y = y;
        y += (v.h+5);
        if (idx<_objects.count-1)
        {
            UIImageView *line = [self line];
            line.tag=100;
            [self.contentView addSubview:line];
            line.y = y;
            
            y += (line.h+5);
        }
    }];
}




-(void)ActiondoForManual:(UITapGestureRecognizer*)sender{
    NSLog(@"yanni棒棒---%@",sender.view);
   // [sender.view setBackgroundColor:[UIColor redColor]];
    UIView *v =sender.view;
       RebateDialog *rebateDialog =[RebateDialog rebate];
   // [rebateDialog.sure addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
    //[rebateDialog.cancel addTarget: self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    if ([v isKindOfClass:[OADeatilViewOne class]]) {
        
        OADeatilViewOne* one=(OADeatilViewOne*)v;
       // [one click:one.radioBtn];
//        if (!one.radioBtn.isSelected) {
//            HUDShowMessageforView(@"请先", <#subtitle_#>)
//        }
        if (!one.radioBtn.isSelected) {
            
            [one click:one.radioBtn];
        }
        rebateDialog.userAwardList =one.listObj;
        rebateDialog.zhiXuan.text=[NSString stringWithFormat:@"可分配返点范围为0-%@",one.listObj.directRet1];
        rebateDialog.zhiXuanStr=one.listObj.directRet1;
        rebateDialog.ZhiXuanField.placeholder=one.rowL.text;
        rebateDialog.LotName.text =self.title.text;
        rebateDialog.awardGroup.text=one.titleL.text;
        rebateDialog.buDingWei.hidden=YES;
        rebateDialog.buDingWeiField.hidden=YES;
        
    }else if([v isKindOfClass:[OADeatilViewTwo class]]){
        OADeatilViewTwo *two =(OADeatilViewTwo*)v;
        if (!two.radioBtn.isSelected) {
            
            [two click:two.radioBtn];
        }
        rebateDialog.userAwardList =two.listObj;
        rebateDialog.zhiXuan.text =[NSString stringWithFormat:@"可分配返点范围为0-%@",two.listObj.directRet1];
        rebateDialog.zhiXuanStr=two.listObj.directRet1;
        rebateDialog.buDingWei.text =[NSString stringWithFormat:@"可分配返点范围为0-%@",two.listObj.threeoneRet1];
        rebateDialog.buDingWeiStr=two.listObj.threeoneRet1;
        rebateDialog.ZhiXuanField.placeholder=two.row1L.text;
        rebateDialog.buDingWeiField.placeholder=two.row2L.text;
        rebateDialog.awardGroup.text =two.titleL.text;
        rebateDialog.LotName.text =self.title.text;
    }
    //contentView.delegate =self;
    self.cover=[[CoverView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [[[UIApplication sharedApplication]keyWindow] addSubview:self.cover];
    //        [self.cover release];
    self.cover.isDisplay=YES;

    rebateDialog.backgroundColor =[UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1.0];
    //contentView.userInteractionEnabled=NO;
    rebateDialog.centerY=self.cover.center.y-70;
    rebateDialog.centerX =self.cover.center.x;
    rebateDialog.layer.cornerRadius = 50/10;/////////////////////////自己试着改变这个值，看看各个不同的效果。现在的设置是画了个圆圈。
    rebateDialog.layer.masksToBounds = YES;//////////////////////////
    //UIButton *btn =[[UIButton alloc] init];
    [self.cover addSubview:rebateDialog];
    // [rebateDialog release];
    // [contentView release];
    



}
-(void)Actiondo:(UITapGestureRecognizer*)sender{
    NSLog(@"yanni棒棒---%@",sender.view);
    UIView *v =sender.view;
         self.cover=[[CoverView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        [[[UIApplication sharedApplication]keyWindow] addSubview:self.cover];
//        [self.cover release];
        self.cover.isDisplay=YES;
        RebateDialog *rebateDialog =[RebateDialog rebate];
    [rebateDialog.sure addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
    [rebateDialog.cancel addTarget: self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    if ([v isKindOfClass:[OADeatilViewOne class]]) {
        OADeatilViewOne* one=(OADeatilViewOne*)v;
        rebateDialog.zhiXuan.text=[NSString stringWithFormat:@"可分配返点范围为0-%@",one.listObj.threeoneRet];
        rebateDialog.LotName.text =one.obj.lot_name;
        
        rebateDialog.buDingWei.hidden=YES;
    }else if([v isKindOfClass:[OADeatilViewTwo class]]){
        OADeatilViewTwo *two =(OADeatilViewTwo*)v;
        rebateDialog.zhiXuan.text =[NSString stringWithFormat:@"可分配返点范围为0-%@",two.listObj.directRet];
        rebateDialog.buDingWei.text =[NSString stringWithFormat:@"可分配返点范围为0-%@",two.listObj.threeoneRet];
        rebateDialog.LotName.text =two.obj.lot_name;
    }
           //contentView.delegate =self;
        
        rebateDialog.backgroundColor =[UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1.0];
        //contentView.userInteractionEnabled=NO;
        rebateDialog.centerY=self.cover.center.y-100;
        rebateDialog.centerX =self.cover.center.x;
        rebateDialog.layer.cornerRadius = 50/4;/////////////////////////自己试着改变这个值，看看各个不同的效果。现在的设置是画了个圆圈。
        rebateDialog.layer.masksToBounds = YES;//////////////////////////
        //UIButton *btn =[[UIButton alloc] init];
        [self.cover addSubview:rebateDialog];
   // [rebateDialog release];
        // [contentView release];
        
        
    


}


-(void)sure{
    
}

-(void)cancel{
    [self.cover removeFromSuperview];

}


-(void)setUpSubview:(UIViewController*)vc
{
    [self.contentView.subviews enumerateObjectsUsingBlock:^(UIView* obj, NSUInteger idx, BOOL *stop) {
        if (obj.tag==100) {
            [obj performSelector:@selector(removeFromSuperview)];
        }
    }];
    OpenLinkDetailObject *o = _objects.firstObject;
    self.title.text = o.lot_name;
    
    __block CGFloat x=0,y=45;
    
    [_objects enumerateObjectsUsingBlock:^(OpenLinkDetailObject* obj, NSUInteger idx, BOOL *stop) {
        
        UIView *v = [OADeatilView oadetailviewwithobject:obj];
        if ([v isKindOfClass:[OADeatilViewOne class]]) {
            OADeatilViewOne *one=(OADeatilViewOne *)v;
            [one.radioBtn setImage:ResImage(@"checkon.png") forState:UIControlStateSelected];
           // one.obj =obj;
           // obj.radioBtn =one.radioBtn;
        }else if ([v isKindOfClass:[OADeatilViewTwo class]]){
               OADeatilViewTwo*two=(OADeatilViewTwo *)v;
            [two.radioBtn setImage:ResImage(@"checkon.png") forState:UIControlStateSelected];
           // two.obj=obj;
           // obj.radioBtn=two.radioBtn;
        }
        
        
               v.tag = 100;
        [self.contentView addSubview:v];
        v.x = x;
        v.y = y;
        y += (v.h+5);
        if (idx<_objects.count-1)
        {
            UIImageView *line = [self line];
            line.tag=100;
            [self.contentView addSubview:line];
            line.y = y;
            
            y += (line.h+5);
        }
    }];
}





+(CGFloat)cellHeightWithObjects:(NSArray*)objects
{
    return 45 + objects.count * [OADeatilView oaheight:objects.firstObject] + (objects.count-1)*12 + 5;
}

+(CGFloat)cellHeightWithObjectsForManaul:(NSArray*)objects
{
    return 45 + objects.count * [OADeatilView oaheightForManaul:objects.firstObject] + (objects.count-1)*12 + 5;
}



-(UIImageView*)line
{
    UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(24, 0, 273, 2)];
    line.image = ResImage(@"oa_detail_cell_xu_line.png");
    return [line autorelease];
}
@end
