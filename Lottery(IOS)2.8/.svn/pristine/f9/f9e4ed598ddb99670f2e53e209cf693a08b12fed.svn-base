//
//  CardPwdInputViewController.m
//  Caipiao
//
//  Created by danal-rich on 13-12-2.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "CardPwdInputViewController.h"
#import "AddCardViewController.h"

#import "CardCellView.h"
#import "RQCardBinding.h"

@interface CardPwdInputViewController ()<RQBaseDelegate>

@end

@implementation CardPwdInputViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"卡号绑定";
    self.view.backgroundColor = kLightGrayBGColor;
    
    CGRect rect = _cardView.frame;
    
    CardCellView *cardView = (id)[CardCellView loadFromNib];
    cardView.frame = rect;
    [_cardView.superview addSubview:cardView];
    _cardView = cardView;
    
    cardView.bankLbl.text = _bankCard.bank_name;
    cardView.detailLbl.text = [CardCellView secrectCard:_bankCard.account];
    cardView.iconView.image = ResImage(_bankCard.bank_name);
    cardView.deleteButton.hidden = YES;
    
    _accountField.delegate = _nameField.delegate = self;
    _submitButton.enabled = NO;
    [_accountField addTarget:self action:@selector(onFieldEdit:) forControlEvents:UIControlEventEditingChanged];
    [_nameField addTarget:self action:@selector(onFieldEdit:) forControlEvents:UIControlEventEditingChanged];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onFieldEdit:(id)sender{
    _submitButton.enabled = [_accountField.text length] * [_nameField.text length] > 0;
}

- (IBAction)submitAction:(id)sender{
    if ([_accountField.text length] * [_nameField.text length] > 0){
        RQCardConfirm *cardConfirm = [[[RQCardConfirm alloc] init] autorelease];
        cardConfirm.bankId = self.bankCard.bindId
        ;
        cardConfirm.bankAccount = _accountField.text;
        cardConfirm.bankAccountName = _nameField.text;
        [cardConfirm startPostWithDelegate:self];
        self.rq = cardConfirm;
    }
}

- (IBAction)dismissKeyboard:(id)sender{
    [self.view endEditing:YES];
    CGRect rect = _contentView.frame;
    rect.origin.y = 0;
    _contentView.frame = rect;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self dismissKeyboard:nil];
}

#pragma mark - TextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self dismissKeyboard:nil];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    CGRect rect = _contentView.frame;
    rect.origin.y = 0;
    if (textField == _nameField){
        rect.origin.y = - 50.f;
        _contentView.frame = rect;
    }
    _contentView.frame = rect;
}

#pragma mark - Request
- (void)onRQStart:(RQBase *)rq{
    [HUDView showLoading:self.view];
}

- (void)onRQComplete:(RQBase *)rq error:(NSError *)error{
    [HUDView dismissCurrent];
    RQCardConfirm *cardConfirm = (id)rq;
    if (cardConfirm.statusOK){
        //Next, to add a card
        AddCardViewController *vc = [[AddCardViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        [vc release];
    } else if (cardConfirm.msgContent) {
        HUDShowMessage(cardConfirm.msgContent, nil);
#ifdef DEBUG
        //        AddCardViewController *vc = [[AddCardViewController alloc] init];
        //        [self.navigationController pushViewController:vc animated:YES];
        //        [vc release];
#endif
    }
}



@end
