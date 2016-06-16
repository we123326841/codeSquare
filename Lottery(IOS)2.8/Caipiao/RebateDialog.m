//
//  RebateDialog.m
//  Caipiao
//
//  Created by 王浩 on 15/10/26.
//  Copyright © 2015年 yz. All rights reserved.
//

#import "RebateDialog.h"

@implementation RebateDialog

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */


-(void)awakeFromNib{
    NSLog(@"awakeFromNib");
      _ZhiXuanField.delegate =self;
     _buDingWeiField.delegate=self;
    [_ZhiXuanField addTarget:self action:@selector(textFieldDidChangeForZhiXuan:) forControlEvents:UIControlEventEditingChanged];
    [_buDingWeiField addTarget:self action:(@selector(textFieldDidChangeForBudingWei:)) forControlEvents:UIControlEventEditingChanged];
    [_sure addTarget:self action:@selector(btnSure) forControlEvents:UIControlEventTouchUpInside];
    [_cancel addTarget: self action:@selector(btnCancel) forControlEvents:UIControlEventTouchUpInside];
    
    
    
}


-(void)btnCancel{
    
    [self.superview removeFromSuperview];
    
}

-(void)btnSure{
    if (_buDingWeiField.isHidden) {
        if (_ZhiXuanField.text.length) {
            if ([_ZhiXuanField.text hasSuffix:@"."]) {
               _ZhiXuanField.text=[_ZhiXuanField.text substringToIndex:_ZhiXuanField.text.length-1];
            }
            if (_userAwardList.radioButtonType==RadioButtonTypeDefault) {
                _userAwardList.defaultDirectRet=_ZhiXuanField.text;
                _userAwardList.directRetReal=_ZhiXuanField.text;
            }else if (_userAwardList.radioButtonType==RadioButtonTypeAll){
                _userAwardList.directRet =_ZhiXuanField.text;
                _userAwardList.directRetReal =_ZhiXuanField.text;
            }else if (_userAwardList.radioButtonType==RadioButtonTypeGuiLin){
                _userAwardList.guiLinDirectRet =_ZhiXuanField.text;
                _userAwardList.directRetReal =_ZhiXuanField.text;
            }
           // _userAwardList.threeoneRet=_ZhiXuanField.text;
        }else{
            HUDShowMessageforView(@"请先设置返点值..", nil);
            return;
        }
        
    }else{
        
        if (_ZhiXuanField.text.length&&_buDingWeiField.text.length==0) {
            [_buDingWeiField becomeFirstResponder];
            return;
        }else if (_ZhiXuanField.text.length&&_buDingWeiField.text.length){
            if ([_ZhiXuanField.text hasSuffix:@"."]) {
                _ZhiXuanField.text=[_ZhiXuanField.text substringToIndex:_ZhiXuanField.text.length-1];
            }
            
            if ([_buDingWeiField.text hasSuffix:@"."]) {
                _buDingWeiField.text=[_buDingWeiField.text substringToIndex:_buDingWeiField.text.length-1];
            }
            
            
            if (_userAwardList.radioButtonType==RadioButtonTypeDefault) {
                _userAwardList.defaultDirectRet=_ZhiXuanField.text;
                _userAwardList.directRetReal =_ZhiXuanField.text;
                _userAwardList.defaultThreeoneRet =_buDingWeiField.text;
                _userAwardList.threeoneRetReal =_buDingWeiField.text;
            }else if (_userAwardList.radioButtonType==RadioButtonTypeAll){
                _userAwardList.directRet=_ZhiXuanField.text;
                _userAwardList.directRetReal =_ZhiXuanField.text;
                _userAwardList.threeoneRet =_buDingWeiField.text;
                _userAwardList.threeoneRetReal=_buDingWeiField.text;
            }else if (_userAwardList.radioButtonType==RadioButtonTypeGuiLin){
                _userAwardList.guiLinDirectRet=_ZhiXuanField.text;
                _userAwardList.directRetReal=_ZhiXuanField.text;
                _userAwardList.guiLinThreeoneRet =_buDingWeiField.text;
                _userAwardList.threeoneRetReal =_buDingWeiField.text;
            }
            
            
            
          //  _userAwardList.directRet =_ZhiXuanField.text;
        //_userAwardList.threeoneRet =_buDingWeiField.text;
        }else{
            HUDShowMessageforView(@"请先设置返点值..", nil);
            return;
        }
       
    }
     [self.superview removeFromSuperview];
    MSNotificationCenterPost(TABLEVIEW_RELOAD);

}



-(void)textFieldDidChangeForZhiXuan:(UITextField*)textField{
    
    if (textField.text.length>=5) {
        HUDShowMessageforView(@"返点超过最大字符", nil);
        textField.text=@"";
        return;
    }

    
    
    if ([textField.text doubleValue]>[_zhiXuanStr doubleValue]) {
        HUDShowMessageforView(@"返点超出上限", nil);
        textField.text=_zhiXuanStr;
        _isHaveDian=YES;
    }
}

-(void)textFieldDidChangeForBudingWei:(UITextField*)textField{
    if (textField.text.length>=5) {
         HUDShowMessageforView(@"返点超过最大字符", nil);
        textField.text=@"";
        return;
    }
    
    if ([textField.text doubleValue]>[_buDingWeiStr doubleValue]) {
        HUDShowMessageforView(@"返点超出上限", nil);
        textField.text=_buDingWeiStr;
          _isHaveDian=YES;
    }
}





-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if ([textField.text rangeOfString:@"."].location==NSNotFound) {
        _isHaveDian=NO;
    }
    if ([string length]>0)
    {
        unichar single=[string characterAtIndex:0];//当前输入的字符
        if ((single >='0' && single<='9') || single=='.')//数据格式正确
        {
            //首字母不能为0和小数点
            if([textField.text length]==0){
                if(single == '.'){
                    NSLog(@"亲，第一个数字不能为小数点");
                    
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                    
                }
//                if (single == '0') {
//                    NSLog(@"亲，第一个数字不能为0");
//                    
//                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
//                    return NO;
//                    
//                }
            }
            if (single=='.')
            {
                if(!_isHaveDian)//text中还没有小数点
                {
                    _isHaveDian=YES;
                    return YES;
                }else
                {
                    NSLog(@"亲，您已经输入过小数点了");
                    
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
            }
            else
            {
                if (_isHaveDian)//存在小数点
                {
                    //判断小数点的位数
                    NSRange ran=[textField.text rangeOfString:@"."];
                    int tt=range.location-ran.location;
                    if (tt <= 2){
                        return YES;
                    }else{
                        NSLog(@"亲，您最多输入两位小数");
                        
                        return NO;
                    }
                }
                else
                {
                    return YES;
                }
            }
        }else{//输入的数据格式不正确
            NSLog(@"亲，您输入的格式不正确");
            [textField.text stringByReplacingCharactersInRange:range withString:@""];
            return NO;
        }
    }
    else
    {
        return YES;
    }
    
    
}



+(instancetype)rebate{
    return  [[[NSBundle mainBundle] loadNibNamed:@"RebateDialog" owner:nil options:nil]lastObject];
}

- (void)dealloc {
    [_zhiXuanStr release];
    [_buDingWeiStr release];
    [_zhiXuan release];
    [_buDingWei release];
    [_sure release];
    [_cancel release];
    [_LotName release];
    [_awardGroup release];
    [_ZhiXuanField release];
    [_buDingWeiField release];
    [super dealloc];
}
@end
