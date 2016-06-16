//
//  LiuYanPingLunCell.m
//
//
//  Created by xiaojiaxi on 14-8-5.
//  Copyright (c) 2014年 mac001. All rights reserved.
//

#import "AccountCell.h"
#import <QuartzCore/QuartzCore.h>

@interface AccountCell ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,retain) UILabel     *timeMonthL;//时间
@property (nonatomic,retain) UILabel     *timeDayL;//时间
@property (nonatomic,retain) UIImageView *line1;//分割线
@property (nonatomic,retain) UIImageView *line2;//分割线

@property (nonatomic,retain) UITableView   *table;

@end

@implementation AccountCell

-(void)dealloc
{
    self.timeMonthL=nil;
    self.timeDayL=nil;
    self.line1=nil;
    self.line2=nil;
    self.table=nil;

    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGFloat x=0,y=0,w=0,h=0;

        //时间
        x=0;y=10;w=45;h=16;
        UILabel *timeMonth = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
        timeMonth.font=[UIFont systemFontOfSize:12];
        timeMonth.textAlignment=NSTextAlignmentCenter;
        timeMonth.textColor=RGBAi(38,191,166,255);
        timeMonth.backgroundColor=[UIColor clearColor];
        self.timeMonthL=timeMonth;
        [self.contentView addSubview:timeMonth];
        [timeMonth release];
        
        y=30;h=20;
        UILabel *timeDay = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
        timeDay.font=[UIFont boldSystemFontOfSize:22];
        timeDay.textAlignment=NSTextAlignmentCenter;
        timeDay.textColor=RGBAi(38,191,166,255);
        timeDay.backgroundColor=[UIColor clearColor];
        self.timeDayL=timeDay;
        [self.contentView addSubview:timeDay];
        [timeDay release];

     
        UIImageView *line1 = [[UIImageView alloc]initWithFrame:CGRectMake(42,0,2.5,12)];
       [line1 setBackgroundColor:[UIColor colorWithRed:(221)/255.0 green:(237)/255.0 blue:(234)/255.0 alpha:1.0]];
        [self.contentView addSubview:line1];
        self.line1=line1;
        [line1 release];
        
        UIImageView *q = [[UIImageView alloc]initWithFrame:CGRectMake(37,12,12,12)];
        q.layer.borderColor= [UIColor colorWithRed:(221)/255.0 green:(237)/255.0 blue:(234)/255.0 alpha:1.0].CGColor;
        q.layer.cornerRadius=6;
        q.layer.borderWidth=2.5;
        [q setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:q];
        [q release];
        
        UIImageView *line2 = [[UIImageView alloc]initWithFrame:CGRectMake(42,25,2.5,h)];
        [line2 setBackgroundColor:[UIColor colorWithRed:(221)/255.0 green:(237)/255.0 blue:(234)/255.0 alpha:1.0]];
        [self.contentView addSubview:line2];
        self.line2=line2;
        [line2 release];
        
        x=45;y=0;w=270;h=0;
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(x, y, w, h)];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [tableView setBackgroundColor:[UIColor clearColor]];
        tableView.scrollEnabled=NO;
        self.table=tableView;
        [self addSubview:_table];
        self.table.delegate = self;
        self.table.dataSource = self;
        [tableView release];
    }
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    return self;
}

-(void)layoutSelfSubview
{
    self.timeMonthL.text = [self getMonth];
    self.timeDayL.text = [self getDay];

    CGFloat height = [AccountCell tableHeight:_dataList];
    CGRect tableF = self.table.frame;
    tableF.size.height=height;
    self.table.frame = tableF;
   
    CGRect line2F = _line2.frame;
    line2F.size.height = height-24;
    _line2.frame = line2F;
    
    [self.table reloadData];
}
+(CGFloat)tableHeight:(NSArray*)arr
{
    CGFloat height=0;

    height = arr.count*56;
    
    return height;
}
-(NSString*)getMonth
{
    if (_dataList.count)
    {
        NSString *time = @"";
        
        id model = [_dataList objectAtIndex:0];
        NSArray *units = [_type == kDataTypeGameHistory? [model playTime]:[model begainTime] componentsSeparatedByString:@"-"];
        time = [NSString stringWithFormat:@"%@月",units[1]];
        return time;
    }
    return @"";
}
-(NSString*)getDay
{
    if (_dataList.count)
    {
        NSString *time = @"";
        
        id model = [_dataList objectAtIndex:0];
        NSArray *units = [_type == kDataTypeGameHistory? [model playTime]:[model begainTime] componentsSeparatedByString:@"-"];
        time = [NSString stringWithFormat:@"%@",[units[2] substringToIndex:2]];
        
        return time;
    }
    return @"";
}

#pragma mark -- tableviewDelegate
-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(cell:subCell:indexpath:)])
    {
        MyAccountCell *cell = (MyAccountCell*)[tableView cellForRowAtIndexPath:indexPath];
        [self.delegate cell:self subCell:cell indexpath:indexPath];
    }
}

#pragma mark -- tableviewDatasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataList.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static  NSString *identify=@"MyAccountCell";
    MyAccountCell *cell=[tableView dequeueReusableCellWithIdentifier:identify];
    if(cell==nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MyAccountCell" owner:self options:nil] lastObject];
    }
    
    if (_type == kDataTypeGameHistory) {
        GameRecord *model = [_dataList objectAtIndex:indexPath.row];
        cell.lotteryLabel.text = model.lotteryName;
        [cell.lotteryLabel sizeToFit];
        cell.object=model;
//        cell.methodLabel.text = [NSString stringWithFormat:@"[%@]",model.methodName];
        [cell.methodLabel sizeToFit];
        
        CGRect r = cell.methodLabel.frame;
        r.origin.x = cell.lotteryLabel.frame.origin.x+cell.lotteryLabel.frame.size.width;
        r.origin.y = cell.lotteryLabel.frame.origin.y;
        cell.methodLabel.frame = r;
        
        cell.timeLabel.text = model.playTime;
        cell.subStatusLabel.textColor = Color(@"MyAccountCellStatusColor");
        cell.statusLabel.textColor=Color(@"MyAccountCellStatusColor");
        if (model.win == 1) {
            cell.statusLabel.text = @"";
            cell.subStatusLabel.text = @"等待开奖";
        }else if (model.win == 2) {
            cell.statusLabel.text = @"已中奖";
            cell.subStatusLabel.text = model.bonus;
            cell.subStatusLabel.textColor = Color(@"MyAccountCellSubStatusColor");
            cell.statusLabel.textColor=Color(@"MyAccountCellSubStatusColor");
        }else if (model.win == 3) {
            cell.statusLabel.text = @"";
            cell.subStatusLabel.text = @"未中奖";
        }else if (model.win == 4) {
            cell.statusLabel.text = @"";
           cell.subStatusLabel.text = @"撤销";
        }else if (model.win == 5) {
            cell.statusLabel.text = @"";
            cell.subStatusLabel.text = @"存在异常";
        }
        else if (model.win == 6) {
            cell.statusLabel.text = @"";
            cell.subStatusLabel.text = @"数据归档";
        }
        
        cell.amountLabel.text = [NSString stringWithFormat:@"￥%@",[SharedModel formatBalance:model.amount]];
    }else {
        ZhuiHaoInfoItem *model = [_dataList objectAtIndex:indexPath.row];
        cell.lotteryLabel.text = model.lotteryName;
        [cell.lotteryLabel sizeToFit];
        cell.object=model;
//        cell.methodLabel.text = [NSString stringWithFormat:@"[%@]",model.methodname];
        [cell.methodLabel sizeToFit];
        
        CGRect r = cell.methodLabel.frame;
        r.origin.x = cell.lotteryLabel.frame.origin.x+cell.lotteryLabel.frame.size.width;
        r.origin.y = cell.lotteryLabel.frame.origin.y;
        cell.methodLabel.frame = r;
        
        cell.timeLabel.text = model.begainTime;
        //0:进行中;1:取消;2:已完成  已终止
        if ([model.status intValue] == 0) {
            cell.statusLabel.text = @"未开始";
        }else if ([model.status intValue] == 1) {
            cell.statusLabel.text = @"进行中";
            cell.subStatusLabel.text = [NSString stringWithFormat:@"追号 %@/%@",model.finishedCount, model.issueCount];
            cell.subStatusLabel.textColor = Color(@"MyAccountCellSubStatusColor");
        }else if ([model.status intValue] == 2) {
            cell.statusLabel.text = @"";
            cell.subStatusLabel.text = @"已结束";
            cell.subStatusLabel.textColor = Color(@"MyAccountCellDisableColor");
        }else if ([model.status intValue] == 3) {
            cell.statusLabel.text = @"";
            cell.subStatusLabel.text = @"已终止";
            cell.subStatusLabel.textColor = Color(@"MyAccountCellSubStatusColor");

        }else if ([model.status intValue] == 4) {
            cell.statusLabel.text = @"暂停";
            cell.subStatusLabel.text = @"";
        }else if ([model.status intValue] == 5) {
            cell.statusLabel.text = @"存在异常";
            cell.subStatusLabel.text = @"";
        }else if ([model.status intValue] == 6) {
            cell.statusLabel.text = @"执行中";
            cell.subStatusLabel.text = @"";
        }else
        {
            cell.statusLabel.text = @"";
            cell.subStatusLabel.text = @"";
        }
        cell.amountLabel.text = [NSString stringWithFormat:@"￥%@",[SharedModel formatBalancef:[model.taskPrice floatValue]]];
        
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 56;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor=[UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
