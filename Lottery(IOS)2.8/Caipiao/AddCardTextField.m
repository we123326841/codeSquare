//
//  AddCardTextField.m
//  Caipiao
//
//  Created by GroupRich on 15/4/14.
//  Copyright (c) 2015年 yz. All rights reserved.
//

#import "AddCardTextField.h"

@implementation AddCardTextField
- (CGRect)editingRectForBounds:(CGRect)bounds
{
    return CGRectMake(95,0, bounds.size.width-95, bounds.size.height);
}
-(CGRect)textRectForBounds:(CGRect)bounds
{
    return CGRectMake(95,0, bounds.size.width-95, bounds.size.height);

}
@end
