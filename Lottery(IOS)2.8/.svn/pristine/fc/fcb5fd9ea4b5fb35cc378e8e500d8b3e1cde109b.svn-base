//
//  OADeatilCell.h
//  Caipiao
//
//  Created by GroupRich on 15/8/2.
//  Copyright (c) 2015年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DetailType)
{
    DetailTypeSSC = 0,
    DetailType11X5,
    DetailTypeKLC,
    DetailTypeDP,
    DetailTypeKS
    
};

@interface OADeatilCell : UITableViewCell
@property (nonatomic,copy)NSArray*objects;
@property (retain, nonatomic) IBOutlet UILabel *title;
+(CGFloat)cellHeightWithObjects:(NSArray*)objects;
+(CGFloat)cellHeightWithObjectsForManaul:(NSArray*)objects;
-(void)setObjects:(NSArray *)objects fromClass:(UIViewController*)vc;
-(void)setObjectsforManual:(NSArray *)objects;
@end
