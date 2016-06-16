//
//  SearchUserViewController.h
//  Caipiao-搜索用户
//
//  Created by danal on 13-10-9.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "BaseViewController.h"

@interface SearchUserViewController : BaseLoadingViewController
<UITextFieldDelegate>
@property (assign, nonatomic) IBOutlet UITextField *textField;
@property (assign, nonatomic) IBOutlet UIButton *cancelButton;

@property (copy, nonatomic) NSString *keyword;
@property (nonatomic) BOOL high;
@property (assign, nonatomic) UINavigationController *nav;

- (IBAction)cancelAction:(id)sender;
- (void)setupTableView;
- (void)searchUser:(NSString *)keyword;
- (void)showHistory;

+ (void)addRecord:(id)record;
+ (NSArray *)searchRecords;
@end
