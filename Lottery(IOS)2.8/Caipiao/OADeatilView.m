//
//  OADeatilView.m
//  Caipiao
//
//  Created by GroupRich on 15/8/5.
//  Copyright (c) 2015年 yz. All rights reserved.
//

#import "OADeatilView.h"
#import "Defines.h"

@implementation OADeatilView

+(UIView*)oadetailviewwithobject:(OpenLinkDetailObject*)object
{
    UIView *v = [OADeatilView loadFromNibWithObject:object];
    [v performSelector:@selector(setupWithObject:) withObject:object];
    return v;
}



+(UIView*)oadetailviewwithobjectForManaul:(UserAwardList*)object
{
    UIView *v = [OADeatilView loadFromNibWithObjectForManual:object];
    [v performSelector:@selector(setupWithObjectForManaul:) withObject:object];
    return v;
}


+ (UIView*)loadFromNibWithObjectForManual:(UserAwardList*)object
{
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"OADeatilView" owner:nil options:nil];
    NSString*  viewclass;
    if (object.rows==1) {
        viewclass = (@"OADeatilViewOne");
    }else
    {
        viewclass = (@"OADeatilViewTwo");
    }
    for (UIView *v in views){
        if ([NSStringFromClass(v.class) isEqualToString:viewclass]){
            return v;
        }
    }
    return nil;
}




+ (UIView*)loadFromNibWithObject:(OpenLinkDetailObject*)object
{
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"OADeatilView" owner:nil options:nil];
    NSString*  viewclass;
    if (object.rows==1) {
        viewclass = (@"OADeatilViewOne");
    }else
    {
        viewclass = (@"OADeatilViewTwo");
    }
    for (UIView *v in views){
        if ([NSStringFromClass(v.class) isEqualToString:viewclass]){
            return v;
        }
    }
    return nil;
}

+(CGFloat)oaheight:(OpenLinkDetailObject*)object
{
    if (object.rows==1) {
        return [OADeatilViewOne oaheight:object];
    }
    if (object.rows==2) {
        return [OADeatilViewTwo oaheight:object];
    }
    return 0;
}

+(CGFloat)oaheightForManaul:(UserAwardList *)object{
    if (object.rows==1) {
        return [OADeatilViewOne oaheightForManaul:object];
    }
    if (object.rows==2) {
        return [OADeatilViewTwo oaheightForManaul:object];
    }
    return 0;


}


@end

@implementation OADeatilViewOne
-(void)awakeFromNib{
    
}
-(void)setupWithObject:(OpenLinkDetailObject*)object
{
    _radioBtn.adjustsImageWhenHighlighted=NO;
     [_radioBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    _titleL.text = object.cnname;
    _rowL.text = [object.labels firstObject];
    _rowV.text = object.userpoint;
    
    _titleL.textColor = Color(@"OALeftColor");
    _rowL.textColor = Color(@"OAMinColor");
    _rowV.textColor = Color(@"OALastColor");
}


-(void)setupWithObjectForManaul:(UserAwardList*)object{
    _radioBtn.adjustsImageWhenHighlighted=NO;
    [_radioBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    _titleL.text = object.awardName;
    _rowL.text = [object.labels firstObject];
    if (object.radioButtonType ==RadioButtonTypeDefault) {
        object.directRetReal =object.defaultDirectRet;
    }else if (object.radioButtonType==RadioButtonTypeGuiLin){
        object.directRetReal =object.guiLinDirectRet;
    }else if (object.radioButtonType==RadioButtonTypeAll){
        object.directRetReal= object.directRet;
    }
    
    _rowV.text =object.directRetReal;
    
    _titleL.textColor = Color(@"OALeftColor");
    _rowL.textColor = Color(@"OAMinColor");
    _rowV.textColor = Color(@"OALastColor");
}

-(void)click:(UIButton*)btn{
    if (_listObj.manualType==ManualSettingTypeAgent) {
        
        btn.selected =!btn.isSelected;
        _listObj.isSelected =btn.selected;
    }else if (_listObj.manualType==ManualSettingTypePlay) {
//               for (UserAwardList *list in _listObjs) {
//                   btn.selected =NO;
//                   _listObj.isSelected =btn.selected;
//
//            if (list==_listObj) {
//                if (btn) {
//                    <#statements#>
//                }
//                btn.selected =!btn.isSelected;
//                
//            }
//                   _listObj.isSelected =btn.selected;
//        }
        [_cell.contentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[OADeatilViewTwo class]]) {
                OADeatilViewTwo *two=(OADeatilViewTwo*)obj;
                two.radioBtn.selected =NO;
                two.listObj.isSelected=two.radioBtn.selected;
            }else if ([obj isKindOfClass:[OADeatilViewOne class]]){
                OADeatilViewOne *one=(OADeatilViewOne*)obj;
                one.radioBtn.selected =NO;
                if (one==self) {
                    one.radioBtn.selected=YES;
                }
                one.listObj.isSelected=one.radioBtn.selected;
                
            }

       
        
        
        }];
        
    }
    NSLog(@"btn1");
}

-(void)checkClick:(UIButton*)btn{
}

- (void)dealloc {
    [_titleL release];
    [_rowL release];
    [_rowV release];
    [_radioBtn release];
    [_obj release];
    [super dealloc];
}
+(CGFloat)oaheight:(OpenLinkDetailObject*)object
{
    return 40;
}

+(CGFloat)oaheightForManaul:(UserAwardList*)object
{
    return 40;
}
@end


@implementation OADeatilViewTwo
-(void)setupWithObject:(OpenLinkDetailObject*)object
{
    _radioBtn.adjustsImageWhenHighlighted=NO;
    [_radioBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    _titleL.text = object.cnname;
    _row1L.text = [object.labels firstObject];
    _row2L.text = [object.labels lastObject ];
    _row1V.text = object.userpoint;
    _row2V.text = object.indefinitePoint;
    
    _titleL.textColor = Color(@"OALeftColor");
    _row1L.textColor = _row2L.textColor = Color(@"OAMinColor");
    _row1V.textColor = _row2V.textColor = Color(@"OALastColor");
}


-(void)setupWithObjectForManaul:(UserAwardList*)object{
    _radioBtn.adjustsImageWhenHighlighted=NO;
    [_radioBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    _titleL.text = object.awardName;
    _row1L.text = [object.labels firstObject];
    _row2L.text = [object.labels lastObject];
    if (object.radioButtonType ==RadioButtonTypeDefault) {
       object.directRetReal=object.defaultDirectRet;
        object.threeoneRetReal= object.defaultThreeoneRet;

    }else if (object.radioButtonType==RadioButtonTypeGuiLin){
        object.directRetReal =object.guiLinDirectRet;
       object.threeoneRetReal = object.guiLinThreeoneRet;
    }else if (object.radioButtonType==RadioButtonTypeAll){
       object.directRetReal  =object.directRet;
       object.threeoneRetReal= object.threeoneRet;
    }
    _row1V.text =object.directRetReal;
    _row2V.text = object.threeoneRetReal;
   
    
    
    
    
    _titleL.textColor = Color(@"OALeftColor");
    //_row1L.textColor = Color(@"OAMinColor");
    //_row1V.textColor = Color(@"OALastColor");
    _row1L.textColor = _row2L.textColor = Color(@"OAMinColor");
    _row1V.textColor = _row2V.textColor = Color(@"OALastColor");
}


-(void)click:(UIButton*)btn{

    if (_listObj.manualType==ManualSettingTypeAgent) {
        
        btn.selected =!btn.isSelected;
        _listObj.isSelected =btn.selected;
    }else if (_listObj.manualType==ManualSettingTypePlay) {
               [_cell.contentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[OADeatilViewOne class]]) {
                OADeatilViewOne *one=(OADeatilViewOne*)obj;
                one.radioBtn.selected =NO;
                one.listObj.isSelected=one.radioBtn.selected;
            }else if ([obj isKindOfClass:[OADeatilViewTwo class]]){
                OADeatilViewTwo *two=(OADeatilViewTwo*)obj;
                two.radioBtn.selected =NO;
                if (two==self) {
                    two.radioBtn.selected=YES;
                }
                two.listObj.isSelected=two.radioBtn.selected;
            
            }
        }];
        
    }

    
    
    NSLog(@"btn2");
}
+(CGFloat)oaheight:(OpenLinkDetailObject*)object
{
    return 40;
}
                
+(CGFloat)oaheightForManaul:(UserAwardList*)object
{
    return 40;
}

- (void)dealloc {
    [_titleL release];
    [_row1L release];
    [_row1V release];
    [_row2L release];
    [_row2V release];
    [_radioBtn release];
    [_obj release];
    [super dealloc];
}

@end