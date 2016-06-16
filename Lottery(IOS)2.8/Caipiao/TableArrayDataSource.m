//
//  TableArrayDataSource.m
//  Caipiao
//
//  Created by GroupRich on 14-10-22.
//  Copyright (c) 2014年 yz. All rights reserved.
//

#import "TableArrayDataSource.h"

@interface TableArrayDataSource ()
@property(nonatomic,strong)NSArray *items;
@property(nonatomic,copy)NSString *cellIdentifier;
@property(nonatomic,copy)TableCellConfigureBlock configureCellBlock;
@end

@implementation TableArrayDataSource

-(void)initWithItems:(NSArray*)anItems
      cellIdentifier:(NSString*)aCellIdentifier
  configureCellBlock:(TableCellConfigureBlock)aConfigureCellBlock
{
    self = [super init];
    if (self) {
        self.items = anItems;
        self.cellIdentifier = aCellIdentifier;
        self.configureCellBlock = [aConfigureCellBlock copy];
    }
}

-(id)itemAtIndexPath:(NSIndexPath*)indexPath
{
   return self.items[(NSUInteger) indexPath.row];
}


#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier
                                                            forIndexPath:indexPath];
    id item = [self itemAtIndexPath:indexPath];
    self.configureCellBlock(cell, item);
    return cell;
}

@end
