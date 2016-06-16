//
//  AdInfoModel.h
//  Caipiao
//
//  Created by cYrus_c on 13-11-15.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AdInfoModel : NSObject

@property (copy, nonatomic) NSString *content;
@property (copy, nonatomic) NSString *imageUrl;
@property (copy, nonatomic) NSString *jumpUrl;
@property (strong, nonatomic) UIImage *image;

@end
