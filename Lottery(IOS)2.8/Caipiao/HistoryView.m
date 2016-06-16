//
//  HistoryView.m
//  Caipiao
//
//  Created by danal-rich on 8/8/14.
//  Copyright (c) 2014 yz. All rights reserved.
//

#import "HistoryView.h"
#import "IssueItem.h"


@implementation HistoryView

- (void)dealloc{
    self.issueItems = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib{
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.backgroundColor = Color(@"BetHistoryBGColor");
    for (UILabel *l in _lbls){
        l.textColor = Color(@"BetHistoryTitleColor");
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
- (void)setIssueItems:(NSArray *)issueItems{
    [_issueItems release];
    _issueItems = [issueItems retain];
    [_tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 26.f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_issueItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell){
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont systemFontOfSize:13.f];
        cell.backgroundColor = cell.contentView.backgroundColor = [UIColor clearColor];
        static CGFloat leftx = 120.f;
        UIImageView *dot = [[UIImageView alloc] initWithImage:ResImage(@"dot.png")];
        dot.frame = CGRectMake(leftx-1.5f, 26.f/2-1.f,
                               dot.frame.size.width, dot.frame.size.height);
        [cell.contentView addSubview:dot];
        [dot release];
        
        UILabel *issueLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.f, 0, leftx-10.f, 26.f)];
        issueLabel.tag = 200;
//        issueLabel.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:issueLabel];
        [issueLabel release];
        
        UILabel *codeLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftx+10.f, 0, 200.f, 26.f)];
        codeLabel.tag = 100;
        [cell.contentView addSubview:codeLabel];
        [codeLabel release];
        
        issueLabel.font = codeLabel.font =  [UIFont fontWithName:kFontProximaNoveReg size:13];//cell.textLabel.font;
        issueLabel.textColor = Color(@"BetHistoryIssueColor");
        codeLabel.textColor = Color(@"BetHistoryCodeColor");
    }
//    cell.textLabel.text = _rowTitles[indexPath.row];
    IssueItem *item = _issueItems[indexPath.row];
    UILabel *codeLabel = (UILabel *)[cell.contentView viewWithTag:100];
    codeLabel.text = item.number;
    UILabel *issueLabel = (UILabel *)[cell.contentView viewWithTag:200];
    issueLabel.text = [NSString stringWithFormat:@"第%@期",item.issueNumber];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
