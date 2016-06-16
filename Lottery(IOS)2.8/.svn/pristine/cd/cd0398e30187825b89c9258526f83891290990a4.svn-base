//
//  AddNewLinkController.m
//  Caipiao
//
//  Created by 王浩 on 15/10/20.
//  Copyright © 2015年 yz. All rights reserved.
//

#import "AddNewLinkController.h"
#import "AgentManualSettingController.h"
#import "PlayManualSettingController.h"
#import "NewLink.h"
@interface AddNewLinkController ()


@end

@implementation AddNewLinkController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setup];
}


- (void)setup{
    //Navigation bar buttons
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:ResImage(@"back.png") forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0.f, 36.f, 40.f);
    
    [button addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self setLeftBarButton:button];
    
    //Compat for ios7
    self.view.backgroundColor = Color(@"ViewBGColor");
    
    //    _agentManualSettingView addta
}



- (IBAction)backAction:(id)sender{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    if ([self.navi.viewControllers count] > 1){
        [self.navi popViewControllerAnimated:YES];
    } else {
        [self.navi.navi popViewControllerAnimated:YES];
    }
}



- (void)setLeftBarButton:(UIButton *)button{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, button.bounds.size.width, button.bounds.size.height)];
    [view addSubview:button];
    view.backgroundColor = [UIColor clearColor];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:view];
    UIBarButtonItem *plain = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:nil action:NULL];
    UIBarButtonItem *fixed = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:NULL];
    if (IOS7){
        fixed.width = -10.f;
    }
    self.navigationItem.leftBarButtonItems = @[plain,fixed,item];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //NSLog(@"%@",indexPath);
    BaseViewController* v =nil;
    if (indexPath.section==1&&indexPath.row==0) {
        v= [[PlayManualSettingController alloc]init];
        [self.navigationController pushViewController:v animated:YES];

    }else if(indexPath.section==0&&indexPath.row==0){
       v = [[AgentManualSettingController alloc]init];
        [self.navigationController pushViewController:v animated:YES];
    }
}

-(void)performSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    NSLog(@"per");

}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
   // NSLog(@"%@",((UIButton*)sender).currentTitle );
   // NSLog(@"identifier %@",[sender  identifier]);
  //  NSLog(@"source %@",[sender sourceViewController]);             //此处报错，因为获取的sender是button
   // NSLog(@"destination %@",[sender destinationViewController]);
   NewLink *link =[segue destinationViewController];
    link.type=NewLinkSettingTypeFast;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


@end
