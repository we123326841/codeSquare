//
//  TextFiledDialog.m
//  Caipiao
//
//  Created by 王浩 on 15/10/16.
//  Copyright © 2015年 yz. All rights reserved.
//

#import "TextFiledDialog.h"
@interface TextFiledDialog()
@property(nonatomic,assign)int length;
@end
@implementation TextFiledDialog

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */



-(void)awakeFromNib{
    NSLog(@"awakeFromNib");
    _textFiled.delegate =self;
    [_textFiled addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
}


- (IBAction)sure:(id)sender {
    
    if(self.length<4){
//    UIAlertView *tip = [[UIAlertView alloc] initWithTitle:@"温馨提醒" message:@"请输入4-16位字符" delegate:nil cancelButtonTitle:nil
// otherButtonTitles:nil];
//    [tip show];
//        
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [tip dismissWithClickedButtonIndex:0 animated:YES];
//        });
        HUDShowMessageforView(@"请输入4-16位字符", nil);
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(textFiledDialog:didButtonClick:)]) {
        [self.delegate textFiledDialog:self didButtonClick:TextFiledDialogButtonTypeSure];
    }
    
    

    
}


-(void)setLinkObject:(OpenLinkObject *)linkObject{
    _linkObject =linkObject;
    if (_linkObject.remark.length) {
        _textFiled.placeholder =_linkObject.remark;
    }

}
- (IBAction)cancel:(id)sender {
    [self.superview removeFromSuperview];
}


//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//    //    if (textField == self.textFiled) {
//    //        if (textField.text.length>20) return NO;
//    //    }
//    //
//    //    return YES;
//   // NSLog(@"------- %@   ---%@",self.textFiled.text,textField.text);
//    
//    
//    if (textField == self.textFiled) {
//        
//        
//       NSString *newStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
//        
//        
//        // 要求：昵称唯一，中文、数字、字母和下划线随意组合，长度1到20个字符（10个汉字），字母区分大小写。
//        // 因为utf 8 是可变长度的，所以还要处理一下
//        int length = 0;
//        for (int i = 0; i < newStr.length; i++) {
//            NSString *subString = [newStr substringWithRange:NSMakeRange(i, 1)];
//            const char *cString = [subString UTF8String];
//            if (strlen(cString) >= 2) {
//                length += 2;
//            } else {
//                length ++;
//            }
//        }
//        
//        if (length <= 16) {
//            return YES;
//        } else {
//            return NO;
//        }
//        
//        
////        if (string.length == 0) return YES;
////        
////        NSInteger existedLength = textField.text.length;
////        NSInteger selectedLength = range.length;
////        NSInteger replaceLength = string.length;
////        
////       // NSLog(@"%lu %lu %lu ",textField.text.length,range.length,string.length);
////        
////        
////        if (existedLength - selectedLength + replaceLength > 16) {
////            return NO;
////        }
//    }
//    
//    return YES;
//    
//    
//    
//    
//}

- (void)textFieldDidChange:(UITextField *)textField
{
    
    
    
   // NSLog(@"%@",[self convertToInt:textField.text]);
    
    
   // NSLog(@"---%d",textField.text.length);
    
    
    
    if (textField == self.textFiled) {
        
//        NSString *newStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
         NSString *newStr = self.textFiled.text;
        
        
        // 要求：昵称唯一，中文、数字、字母和下划线随意组合，长度1到20个字符（10个汉字），字母区分大小写。
        // 因为utf 8 是可变长度的，所以还要处理一下
         self.length = 0;
        for (int i = 0; i < newStr.length; i++) {
            NSString *subString = [newStr substringWithRange:NSMakeRange(i, 1)];
            const char *cString = [subString UTF8String];
            if (strlen(cString) >= 2) {
                self.length += 2;
            } else {
                self.length ++;
            }
            
            if (self.length >= 16) {
                textField.text = [newStr substringToIndex:i+1];
                break;
            }
        }
        
//        if (length <= 16) {
//            return YES;
//        } else {
//            return NO;
//        }
        
        
//        if (textField.text.length > 16) {
//            textField.text = [textField.text substringToIndex:16];
//        }
    }
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_textFiled resignFirstResponder];
    NSLog(@"%s",__FUNCTION__);
    return YES;
}


- (void)dealloc {
    
}



- (int)convertToInt:(NSString*)strtemp
{
    int strLength = 0;
    char *p = (char *)[strtemp cStringUsingEncoding:NSUnicodeStringEncoding];
    int length = [strtemp lengthOfBytesUsingEncoding:NSUnicodeStringEncoding];
    
    for (int i = 0; i < length; i ++) {
        if (*p) {
            p ++;
            strLength ++;
        }else{
            p ++;
        }
    }
    
    return (strLength+1)/2;
}


@end
