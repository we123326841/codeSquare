//
//  SecurityIssuesVC.m
//  Caipiao
//
//  Created by GroupRich on 14-11-12.
//  Copyright (c) 2014年 yz. All rights reserved.
//

#import "SecurityIssuesVC.h"
#import "SelectSecurityIsussesVC.h"
#import "MSBlockAlertView.h"

#define  isAuthSafe   ![[[CDUserInfo user] needSetSafeQuest]integerValue] //true:尚未设定安全问题密码

@interface SecurityIssuesVC ()
PSTRONG NSMutableDictionary *issues;
@end


@implementation SecurityIssuesVC

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.title = @"安全问题";
    UIButton *rightButton = [UIButton barButtonWithTitle:@"     完成"];
    rightButton.frame = CGRectMake(0, 0, 60, rightButton.bounds.size.height);
    [rightButton addTarget:self action:@selector(save:) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setTitleColor:RGBAi(200,200, 200, 255) forState:UIControlStateNormal];
    [self setRightBarButton:rightButton];
    [self.navigationItem.rightBarButtonItem setEnabled:NO];
    self.navigationItem.rightBarButtonItem.customView.hidden = NO;
    
    self.issues=[NSMutableDictionary dictionary];
    
    _scroll.contentSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height);
    
    [self loadData];
    
    if (isAuthSafe)
    {
        if (_type==ComeTypeEdit)
            return;
        _bg.hidden=YES;
        _quest3L.hidden=YES;
        _answer3L.hidden=YES;
        _fieldThird.hidden=YES;
        _btn3L.hidden=YES;
        self.title = @"验证安全问题";
        _type=ComeTypeVerify;
        [[self rightButton] setTitle:@"下一步" forState:UIControlStateNormal];
    }
    _answerAlertLbl = [[UILabel alloc]initWithFrame:CGRectMake(15, 290, 310, 45)];
    _answerAlertLbl.text = @"答案包含4-16位字符，可由中文、字母及数字组成";
    _answerAlertLbl.font = [UIFont systemFontOfSize:12];
    _answerAlertLbl.textColor = [UIColor lightGrayColor];
    _answerAlertLbl.backgroundColor=self.view.backgroundColor;
    [_bg addSubview:_answerAlertLbl];
    [_answerAlertLbl release];
}
-(void)loadData
{
    [HUDView showLoadingToView:KEY_WINDOW msg:kStringLoading subtitle:nil];
    [HUDView setTouchHide:NO];

    RQSafeQuestInit *rq = [[RQSafeQuestInit alloc]init];
    self.rq=rq;
    [rq release];
    [rq startPostWithBlock:^(id rq_, NSError *error_, id rqSender_) {
        HUDHide();
        QuestEntity *q = [[QuestEntity alloc]init];
        q.qid=-1;
        q.question=@"无";
        q.isUsed=0;
        [[(RQSafeQuestInit *)rq_ issues] insertObject:q atIndex:0];
        [q release];
    } sender:nil];
}
-(UIButton*)rightButton
{
    UIBarButtonItem *item = self.navigationItem
    .rightBarButtonItem;
    UIButton *btn = (UIButton*)item.customView;
    return btn;
}
-(BOOL)haveBeenSetSafe:(RQSafeQuestInit*)rq
{
    for (QuestEntity *q in rq.issues) {
        if (q.isUsed==1) {
            return YES;
        }
    }
    return NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)selectIsussesAction:(id)sender
{
    UIButton *btn = (UIButton*)sender;
    
    SelectSecurityIsussesVC *vc = [[SelectSecurityIsussesVC alloc]init];
    vc.lastIndexPath=[NSIndexPath indexPathForRow:0 inSection:0];
    vc.issues = [self selectIssues:[sender tag]];
    for (QuestEntity *qe in vc.issues) {
        if ([qe.question isEqualToString:[btn titleForState:UIControlStateNormal]]) {
           vc.lastIndexPath=[NSIndexPath indexPathForRow:[vc.issues indexOfObject:qe] inSection:0];
        }
    }
    vc.completeBlock = ^(QuestEntity *issue){
        
        if (![issue.question isEqualToString:@"无"]) {
            [btn setTitle:issue.question forState:UIControlStateNormal];
            [_issues setObject:issue forKey:[NSString stringWithFormat:@"%li",(long)btn.tag]];

        }else
        {
            [btn setTitle:@"" forState:UIControlStateNormal];
            [_issues removeObjectForKey:[NSString stringWithFormat:@"%li",(long)btn.tag]];
            
        }
                [self setRightBarItem];
    };
    vc.type = _type==ComeTypeVerify?SelectTypeAuthentication:SelectTypeDefault;
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
}

-(NSMutableArray *)selectIssues:(NSInteger)tag
{
    NSMutableArray *issues =  [NSMutableArray array];
    [issues addObjectsFromArray:((RQSafeQuestInit*)self.rq).issues];
    if (_type==ComeTypeVerify) {
        NSMutableArray *unused = [NSMutableArray array];
        for (QuestEntity *q in issues) {
            if (q.isUsed==0) [ unused addObject:q];
        }
        [issues removeObjectsInArray:unused];
    }
    NSMutableArray *selectedissues = [NSMutableArray array];
    for (NSString *key in [_issues allKeys]) {
        if ([key integerValue]!=tag) {
            [selectedissues addObject:[_issues objectForKey:key]];
        }
    }
    [issues removeObjectsInArray:selectedissues];
    return issues;
}
-(void)save:(UIButton*)btn
{
    NSMutableArray *issues = [NSMutableArray array];
    if ([_issues objectForKey:@"1"])
     [issues addObject:[_issues objectForKey:@"1"]];
     if ([_issues objectForKey:@"2"])
    [issues addObject:[_issues objectForKey:@"2"]];
     if ([_issues objectForKey:@"3"])
    [issues addObject:[_issues objectForKey:@"3"]];
    NSMutableArray *quests = [NSMutableArray array];
    [issues enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        QuestEntity *q = (QuestEntity*)obj;
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:@(q.qid) forKey:@"qid"];
        if (idx==0) {
            [dic setObject:[[_fieldOne.text dataUsingEncoding:NSUTF8StringEncoding] md5] forKey:@"qpwd"];
        }
        if (idx==1) {
            [dic setObject:[[_fieldTwo.text dataUsingEncoding:NSUTF8StringEncoding] md5]  forKey:@"qpwd"];
        }
        if (idx==2) {
            [dic setObject:[[_fieldThird.text dataUsingEncoding:NSUTF8StringEncoding] md5]  forKey:@"qpwd"];
        }
        [quests addObject:dic];
    }];
    [HUDView showLoadingToView:KEY_WINDOW msg:kStringWaiting subtitle:nil];

    RQSafeQuestSet *rq = nil;
    if (_type==ComeTypeVerify) {
        rq = [[RQSafeQuestVerify alloc]init];
    }else if(_type==ComeTypeEdit)
    {
        rq = [[RQSafeQuestEdit alloc]init];
    }else
        rq= [[RQSafeQuestSet alloc]init];

    
    
    rq.quests = quests;
    [rq startPostWithBlock:^(id rq_, NSError *error_, id rqSender_) {
        HUDHide();
        NSString *content = [(RQSafeQuestSet*)rq_ msgContent];
        if (content){
            HUDShowMessage(content,nil);
            
        } else if ([[(RQSafeQuestSet*)rq_ status] isEqualToString:@"success"])
        {
            if ( _type==ComeTypeVerify) {
                SecurityIssuesVC *vc = [[SecurityIssuesVC alloc]init];
                vc.type = ComeTypeEdit;
                NSMutableArray *controllers = [self.navigationController.viewControllers mutableCopy];
                [controllers removeLastObject];
                [controllers addObject:vc];
                [self.navigationController setViewControllers:controllers animated:YES];
                [controllers release];
                [vc release];
                return ;
            }
            
            [CDUserInfo user].needSetSafeQuest=@(NO);
            [[CDUserInfo user] save];
            
            SecuritySettingResultVC *vc = [[SecuritySettingResultVC alloc]init];
            if (_type==ComeTypeCash) {
                vc.type = ResultTypeCashSuccess;
            }else if(_type==ComeTypeCardBing)
                vc.type = ResultTypeCardBingSuccess;
            else
                vc.type = ResultTypeSettingSuccess;
            [self.navigationController pushViewController:vc animated:YES];
            [vc release];
        }
    } sender:nil];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if ([self filterBlank:textField.text].length>0&&![self ismatch:textField.text])
    {
        textField.text=@"";
        MSBlockAlertView *alert = [[MSBlockAlertView alloc] initWithTitle:nil message:@"答案包含4-16位字符，可由中文、字母及数字组成" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert setClickBlock:^(MSBlockAlertView *a, NSInteger index) {
        }];
        [alert show];
    }
            [self setRightBarItem];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    [self setRightBarItem];
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    [[self rightButton] setTitleColor:RGBAi(200,200, 200, 255) forState:UIControlStateNormal];
    [self.navigationItem.rightBarButtonItem setEnabled:NO];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    return YES;
}
-(void)setRightBarItem
{
    if ([self isCanSave]) {
        [[self rightButton] setTitleColor:RGBAi(255,255, 255, 255) forState:UIControlStateNormal];
        [self.navigationItem.rightBarButtonItem setEnabled:YES];
    }else {
        [[self rightButton] setTitleColor:RGBAi(200,200, 200, 255) forState:UIControlStateNormal];
        [self.navigationItem.rightBarButtonItem setEnabled:NO];
    }
}
-(BOOL)isCanSave
{
    NSString *one =[self filterBlank: _fieldOne.text ];
    NSString *two =[self filterBlank:  _fieldTwo.text];
    NSString *third =[self filterBlank:  _fieldThird.text ];
    
    if (_type==ComeTypeVerify) {
        if ([self ismatch:one]&&[self ismatch:two]&&_issues.count>=2) return YES;
    }
    
    if ([self ismatch:one]&&[self ismatch:two]&&[self ismatch:third]&&_issues.count>=3) {
        return YES;
    }
    return NO;
}
-(BOOL)ismatch:(NSString*)text
{
    NSString * regex = @"^[A-Za-z0-9\u4e00-\u9fa5]{0,16}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:text];
    NSInteger unicodeLength = [self unicodeLengthOfString:text];
    return isMatch&&(unicodeLength>16||unicodeLength<4?NO:YES);
}
-(NSUInteger) unicodeLengthOfString: (NSString *) text
{
    NSUInteger asciiLength = 0;
    for (NSUInteger i = 0; i < text.length; i++) {
        unichar uc = [text characterAtIndex: i];
        asciiLength += isascii(uc) ? 1 : 2;
    }
    return asciiLength;
}
-(NSString*)filterBlank:(NSString*)text
{
     NSString *str =[text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    return str;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (void)dealloc {
    [_fieldOne release];
    [_fieldTwo release];
    [_fieldThird release];
    [_bg release];
    [_quest3L release];
    [_answer3L release];
    [_btn3L release];
    [_answerAlertLbl release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setFieldOne:nil];
    [self setFieldTwo:nil];
    [self setFieldThird:nil];
    [self setBg:nil];
    [self setQuest3L:nil];
    [self setAnswer3L:nil];
    [self setBtn3L:nil];
    [self setAnswerAlertLbl:nil];
    [super viewDidUnload];
}


@end
