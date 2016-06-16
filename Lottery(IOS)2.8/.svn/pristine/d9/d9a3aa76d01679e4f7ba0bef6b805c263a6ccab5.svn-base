//
//  DropDownSelector.m
//  Caipiao
//
//  Created by danal-rich on 8/5/14.
//  Copyright (c) 2014 yz. All rights reserved.
//

#import "DropDownSelector.h"

@implementation DropDownSelector

- (void)dealloc{
    Echo(@"%s",__func__);
    self.rowTitles = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.frame = CGRectInset(self.bounds, 8.f, 8.f);
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.clipsToBounds = YES;
        [self addSubview:_tableView];
        [_tableView release];
        
        if ([_tableView respondsToSelector:@selector(separatorInset)]){
            _tableView.separatorInset = UIEdgeInsetsZero;
        }
    }
    return self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 36.f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_rowTitles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell){
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.textLabel.font = [UIFont systemFontOfSize:14.f];
        cell.textLabel.adjustsFontSizeToFitWidth = YES;
        cell.textLabel.textColor = [UIColor darkGrayColor];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    cell.textLabel.text = _rowTitles[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_selectBlock){
        _selectBlock(self,indexPath.row);
    }
//    [self dismiss];
    [_maskView removeFromSuperview];
    [self removeFromSuperview];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    view.backgroundColor = self.backgroundColor;
    return view;
}

- (void)attachToView:(UIView *)view{
    UIButton *mask = [UIButton buttonWithType:UIButtonTypeCustom];
    mask.frame = view.bounds;
    mask.backgroundColor = [UIColor clearColor];
    [mask addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:mask];
    _maskView = mask;
    
    [view addSubview:self];
    
}

- (void)dismiss{
    if (_selectBlock){
        _selectBlock(self,-1);
    }
    [_maskView removeFromSuperview];
    [self removeFromSuperview];
}

@end
