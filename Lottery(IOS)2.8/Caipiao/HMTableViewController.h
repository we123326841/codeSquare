//
//  HMTableViewController.h
//  CaiPiaoDemoyo
//
//  Created by 王浩 on 15/11/17.
//  Copyright © 2015年 王浩. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum{
    HighterChaseNumGeQi,
    HighterChaseNumFenDuan,
    HighterChaseNumYingLiJe,
    HighterChaseNumYingLiRate,
    HighterChaseNumNONE
}HighterChaseNumType;
@interface HMTableViewController : BaseViewController
@property(nonatomic,assign)HighterChaseNumType type;
@end
