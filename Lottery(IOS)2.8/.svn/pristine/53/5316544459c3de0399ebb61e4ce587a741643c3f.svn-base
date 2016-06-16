//
//  MyBetNumberCell.m
//  Caipiao
//
//  Created by GroupRich on 14-10-15.
//  Copyright (c) 2014年 yz. All rights reserved.
//

#import "MyBetNumberCell.h"

@interface MyBetNumberCell ()
@property (nonatomic,retain) UILabel     *number;
@property (nonatomic,retain) UILabel     *name;
@property (nonatomic,retain) UILabel     *count;
@property (nonatomic,retain) UIImageView     *i;
@end

@implementation MyBetNumberCell
//65
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        CGFloat x=10,y=10,w=0,h=20;
        
        w=280;
        UILabel *number = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
        number.font=[UIFont systemFontOfSize:15];
        number.textAlignment=NSTextAlignmentLeft;
        number.textColor=RGBAi(150,150,150,255);
        number.backgroundColor=[UIColor clearColor];
        self.number=number;
        [self.contentView addSubview:number];
        [number release];
        
        y=30;w=120;
        UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
        name.font=[UIFont systemFontOfSize:15];
        name.textAlignment=NSTextAlignmentLeft;
        name.textColor=RGBAi(150,150,150,255);
        name.backgroundColor=[UIColor clearColor];
        self.name=name;
        [self.contentView addSubview:name];
        [name release];
        
        x=180;w=130;
        UILabel *count = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
        count.font=[UIFont systemFontOfSize:15];
        count.textAlignment=NSTextAlignmentRight;
        count.textColor=RGBAi(150,150,150,255);
        count.backgroundColor=[UIColor clearColor];
        self.count=count;
        [self.contentView addSubview:count];
        [count release];
        
        UIImageView *i =  [[UIImageView alloc]initWithFrame:CGRectMake(0, 59, 200, 1)];
        i.image = [UIImage imageNamed:@"Resources.bundle/cell_line.png"];
        [self addSubview:i];
        self.i=i;
        [i release];
        
    }
    self
    .backgroundColor = [UIColor clearColor];
    return self;
}
-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    CGRect r = _i.frame;
    r.size.width = frame.size.width;
    _i.frame = r;
    
}
-(void)setRecord:(RecordInfo *)record
{
    _record = record;
    if ([_record.codedetails isKindOfClass:[NSNull class]])_record.codedetails=@"5";
         if ([_record.methodid isKindOfClass:[NSNull class]])_record.methodid=@"4";
    
    _number.text = _record.codedetails;
    _name.text = _record.methodname;
    _count.text = (_record.ifwin==2||_record.ifwin==3)?[NSString stringWithFormat:@"中奖%.2f元",_record.bonus]:@"" ;
    
    CGRect frame = _count.frame;
    frame.origin.x = self.bounds.size.width-140;
    _count.frame=frame;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
