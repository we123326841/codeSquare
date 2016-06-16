//
//  OldFundViewController.m
//  Caipiao
//
//  Created by danal-rich on 10/15/14.
//  Copyright (c) 2014 yz. All rights reserved.
//

#import "OldFundViewController.h"
#import "TransferFundVC.h"
@interface OldFundViewController ()
@property (strong,nonatomic) NSMutableArray *dataList;
@end

@implementation OldFundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.dataList = [[@[@(0),@(0),@(0)] mutableCopy] autorelease];
    self.tableView.backgroundColor = self.view.backgroundColor;
    self.title = @"资金转移";
    
    UIButton *rightButton = [UIButton barButtonWithTitle:@"     关闭"];
    rightButton.frame = CGRectMake(0, 0, 60, rightButton.bounds.size.height);
    [rightButton addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setTitleColor:RGBAi(250,250, 250, 255) forState:UIControlStateNormal];
    [self setRightBarButton:rightButton];
}
-(void)close:(UIButton*)btn
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"Cell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell){
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId]autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.textColor = [UIColor darkGrayColor];
        cell.textLabel.font = [UIFont systemFontOfSize:14.f];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:16.f];
//        UIImageView *checkView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
//        cell.accessoryView = checkView;
//        [checkView release];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(290,27,30, 20)];
        label.textColor = [UIColor grayColor];
        label.text=@"元";
        label.backgroundColor=RGBAi(255, 204, 106, 0);
        label.font=[UIFont systemFontOfSize:14];
        [cell.contentView addSubview:label];
        [label release];

    }
    UIImageView *checkView = (UIImageView *)cell.accessoryView;
    NSNumber *n = self.dataList[indexPath.row];
    checkView.image = n.boolValue ? ResImage(@"checkon.png"): ResImage(@"checkoff.png");
    switch (indexPath.row) {//您的旧版网站未转移资金
        case 0:
//            cell.textLabel.text = @"银行余额";
            cell.textLabel.text = @"您的可转移资金";
//            cell.detailTextLabel.text = [SharedModel formattedBalance];
            cell.detailTextLabel.text = [SharedModel formattedOldBalance];

            break;
        case 1:
            cell.textLabel.text = @"高频余额";
            cell.detailTextLabel.text = [SharedModel formattedBalance];
            break;
        case 2:
            cell.textLabel.text = @"低频余额";
            cell.detailTextLabel.text = [SharedModel formattedLowBalance];
            break;
        default:
            break;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)] autorelease];
    return view;
    view.backgroundColor = [UIColor clearColor];
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectInset(view.frame, 15, 0)];
    lbl.font = [UIFont systemFontOfSize:15.f];
    lbl.textColor = [UIColor darkGrayColor];
    NSString *nickname = [[SharedModel shared] nickname];
    lbl.text = [NSString stringWithFormat:@"%@ 您的旧版网站资金情况如下",nickname];
    NSMutableAttributedString *astr = [[NSMutableAttributedString alloc] initWithString:lbl.text];
    [astr addAttribute:NSForegroundColorAttributeName value:(id)[UIColor blackColor] range:NSMakeRange(0, nickname.length)];
    lbl.attributedText = astr;
    [astr release];
    [view addSubview:lbl];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 30.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)] autorelease];
    view.backgroundColor = [UIColor clearColor];
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectInset(view.frame, 15, 0)];
    lbl.font = [UIFont systemFontOfSize:13.f];
    lbl.text = @"";//@"您可以同时通过手机或网站查看资金变动情况";
    lbl.textColor = [UIColor darkGrayColor];
    [view addSubview:lbl];
    [lbl release];
    return view ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSNumber *n = self.dataList[indexPath.row];
    self.dataList[indexPath.row] = @(!n.boolValue);
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

- (IBAction)transferAction:(id)sender{
    TransferFundVC *vc = [[TransferFundVC alloc] init];
    vc.fundpwd=self.fundpwd;
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
}

@end
