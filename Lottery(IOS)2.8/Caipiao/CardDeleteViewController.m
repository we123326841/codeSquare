//
//  CardDeleteViewController.m
//  Caipiao
//
//  Created by danal-rich on 13-12-2.
//  Copyright (c) 2013年 yz. All rights reserved.
//
#import "CardDeleteViewController.h"

#import "CardCellView.h"
#import "RQCardBinding.h"

@interface CardDeleteViewController ()<RQBaseDelegate>

@end

@implementation CardDeleteViewController

- (void)dealloc{
    [_bankCard release];
    [_bankCardToDelete release];
    [super dealloc];
}

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
    cardView.userInteractionEnabled = NO;

    _accountField.delegate = _nameField.delegate = self;
    _deleteButton.enabled = NO;
    [_accountField addTarget:self action:@selector(onFieldEdit:) forControlEvents:UIControlEventEditingChanged];
    [_nameField addTarget:self action:@selector(onFieldEdit:) forControlEvents:UIControlEventEditingChanged];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onFieldEdit:(id)sender{
    _deleteButton.enabled = [_accountField.text length] * [_nameField.text length] > 0;
}

- (IBAction)deleteButtonAction:(id)sender{
    [self.view endEditing:YES];
    if ([_accountField.text length] * [_nameField.text length] > 0){
        RQCardDelete *cardDelete = [[[RQCardDelete alloc] init] autorelease];
        cardDelete.bankId = self.bankCardToDelete.bindId;
        cardDelete.account = _accountField.text;
        cardDelete.accountName = _nameField.text;
        [cardDelete startPostWithDelegate:self];
        self.rq = cardDelete;
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
    rect.origin.y = 0.f;
    if (textField == _nameField){
        rect.origin.y = -50.f;
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
    RQCardDelete *cardDelete = (id)rq;
    if (cardDelete.statusOK){
        //Jump to the Hall
        [self.navigationController popViewControllerAnimated:YES];
    } else if (cardDelete.msgContent){
        HUDShowMessage(cardDelete.msgContent, nil);
    }
}

@end
