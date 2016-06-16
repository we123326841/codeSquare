//
//  QRCodeAndShareVC.h
//  Caipiao
//
//  Created by 王浩 on 15/7/30.
//  Copyright (c) 2015年 yz. All rights reserved.
//

#import "BaseViewController.h"
#import "RQOpenLinkList.h"

@interface QRCodeAndShareVC : BaseViewController
@property (nonatomic,retain)OpenLinkObject*object;
@property(nonatomic,copy)NSString *state;
//-(void)setBlock:(void(^)(OpenLinkObject*o))block;
@property(nonatomic,copy)void(^block)(OpenLinkObject*o);
@end
