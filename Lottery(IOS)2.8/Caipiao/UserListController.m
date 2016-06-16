//
//  UserListController.m
//  Caipiao
//
//  Created by 王浩 on 15/10/23.
//  Copyright © 2015年 yz. All rights reserved.
//

#import "UserListController.h"
#import "UserListCell.h"
#import "UserListModel.h"
@interface UserListController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray*userNames;
@end

@implementation UserListController
-(NSMutableArray*)userNames{
    if (_userNames ==nil) {
        _userNames =[NSMutableArray array];
        for(int i =0;i<_users.count;i++){
            UserListModel *model =[[UserListModel alloc]init];
            model.sequence =[NSString stringWithFormat:@"%d",i+1];
            model.name =_users[i];
            [_userNames addObject:model];
        }
    }
    return _userNames;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title =@"用户列表";
    _tableView.delegate =self;
    _tableView.dataSource =self;
    //_tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    _tableView.frame =self.view.bounds;
    
    
    [_tableView registerNib:[UINib nibWithNibName:@"UserList" bundle:nil] forCellReuseIdentifier:@"Cell"];
    
   }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _users.count;

}




-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
   // NSString* userName =_users[indexPath.row];
    static NSString *ID =@"Cell";
    UserListCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
   
    
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    
    [cell setModel:self.userNames[indexPath.row]];
    return cell;
    
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
   // cell.backgroundColor = [UIColor clearColor];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    _users =@[@"dede",@"dededede"];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)dealloc {
  
}
@end
