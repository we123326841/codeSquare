//
//  SelectSecurityIsussesVC.m
//  Caipiao
//
//  Created by GroupRich on 14-11-12.
//  Copyright (c) 2014年 yz. All rights reserved.
//

#import "SelectSecurityIsussesVC.h"

@interface SelectSecurityIsussesVC ()


@end

@implementation SelectSecurityIsussesVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"选择问题";
    
//    QuestEntity *q = [[QuestEntity alloc]init];
//    q.question = @"我的宠物名字";
//    [_issues addObject:q];
//    [q release];
//    QuestEntity *q1 = [[QuestEntity alloc]init];
//    q1.question = @"我的宠物名字";
//    [_issues addObject:q1];
//    [q1 release];
//    QuestEntity *q2 = [[QuestEntity alloc]init];
//    q2.question = @"我的宠物名字";
//    [_issues addObject:q2];
//    [q2 release];
    
    UIButton *rightButton = [UIButton barButtonWithTitle:@"确定"];
    rightButton.frame = CGRectMake(0, 0, 60, rightButton.bounds.size.height);
    [rightButton addTarget:self action:@selector(sure:) forControlEvents:UIControlEventTouchUpInside];
    [self setRightBarButton:rightButton];
    [self.navigationItem.rightBarButtonItem setEnabled:YES];
    self.navigationItem.rightBarButtonItem.customView.hidden = YES;


    _table.frame = CGRectMake(0, 40, 320, self.view.bounds.size.height-130);
    _table.backgroundColor = [UIColor clearColor];
    _table.tableFooterView = [[[UIView alloc]initWithFrame:CGRectMake(0, 0,320, 1)] autorelease];
//    self.lastIndexPath=[NSIndexPath indexPathForRow:0 inSection:0];

}
-(void)sure:(UIButton*)btn
{
//    UITableViewCell *cell = [_table cellForRowAtIndexPath:
//                             self.lastIndexPath];
    QuestEntity *entity = (QuestEntity*)_issues[self.lastIndexPath.row];

    _completeBlock( entity);//cell.textLabel.text
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_issues count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier]autorelease];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textColor = RGBAi(66, 66, 66, 255);
        cell.backgroundColor=[UIColor whiteColor];
        cell.textLabel.backgroundColor = [UIColor clearColor];
    }
    QuestEntity *entity = (QuestEntity*)_issues[indexPath.row];
    cell.textLabel.text =entity.question;
    
    NSUInteger row = [indexPath row];
    NSUInteger oldRow = [_lastIndexPath row];
    if (row == oldRow && _lastIndexPath != nil)
    {
            UIImageView *check = [[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 15, 11.5)]autorelease];
            check.image = [UIImage imageNamed:Res(@"checked.png")];
            cell.accessoryView=check;
    }else
    {
        cell.accessoryView=nil;
          }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*实现单选*/
    NSInteger newRow = [indexPath row];
    /*重复tableView的上一个选中indexPath*/
    NSInteger lastRow = (self.lastIndexPath != nil) ? [self.lastIndexPath row] : -1;
    UITableViewCell *newCell = [tableView cellForRowAtIndexPath:
                                indexPath];
    
    UIImageView *check = [[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 15, 11.5)]autorelease];
    check.image = [UIImage imageNamed:Res(@"checked.png")];
    newCell.accessoryView=check;
    
    if (newRow != lastRow )
    {
        UITableViewCell *lastCell = [tableView cellForRowAtIndexPath:
                                     self.lastIndexPath];
        lastCell.accessoryView=nil;

        self.lastIndexPath = indexPath;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self sure:nil];
    
    return;
}


- (void)dealloc {
    [_table release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setTable:nil];
    [super viewDidUnload];
}
@end
