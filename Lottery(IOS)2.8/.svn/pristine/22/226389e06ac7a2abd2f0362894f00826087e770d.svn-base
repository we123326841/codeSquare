//
//  TableArrayDataSource.h
//  Caipiao
//
//  Created by GroupRich on 14-10-22.
//  Copyright (c) 2014年 yz. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^TableCellConfigureBlock)(id cell , id item);

@interface TableArrayDataSource : NSObject<UITableViewDataSource>

-(void)initWithItems:(NSArray*)anItems
      cellIdentifier:(NSString*)aCellIdentifier
  configureCellBlock:(TableCellConfigureBlock)aConfigureCellBlock;

-(id)itemAtIndexPath:(NSIndexPath*)indexPath;

@end
